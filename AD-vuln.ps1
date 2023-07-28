
#Modified from https://github.com/WazeHell/vulnerable-AD/blob/master/vulnad.ps1

$Global:FirstNames = @('Blair', 'Jesse', 'Tom', 'Ed', 'Adam', 'Celeste', 'Nihal', 'Jordan', 'Chris','Dylan', 'Aaron', 'Tristan', 'Matt', 'David', 'Dakota', 'Christopher', 'Lyndon');
$Global:LastNames = @('Fizzlebottom','Snickerdoodle','Wobblebutt','McSnortle','Bumblefluff','Gigglesworth','Dingleberry','Squishington','Tinkleberry','Wigglesnort','Bubblegum','Noodlebuns','Tootsiemuffin','Picklepants','Gobblefunk','Dankworth','Cheesefoot','Bananabutt','Schnickelsaw','Jellybean','Corolla','Pumpkinhead','Biscuitbottom','Muffinface','Schnitzeltoes','Pickleweasel','Dingledorp','Tootsiepop','Noodlewiggle','Wafflestomp');

$Global:BadPasswords = @('root','logitech','swag','wubao','password','123456','admin','12345','1234','p@ssw0rd','123','1','jiamima','test','root123','!','!q@w','!qaz@wsx','idc!@','admin!@', ' ', 'alpine','qwerty','12345678','111111','123456789','1q2w3e4r','123123','default','1234567','qwe123','1qaz2wsx','1234567890','abcd1234','000000','user','toor','qwer1234','1q2w3e','asdf1234','redhat','1234qwer','cisco','12qwaszx','test123','1q2w3e4r5t','admin123','changeme','1qazxsw2','123qweasd','q1w2e3r4','letmein','server','root1234','master','abc123','rootroot','a','system','pass','1qaz2wsx3edc','p@$$w0rd','112233','welcome','!QAZ2wsx','linux','123321','manager','1qazXSW@','q1w2e3r4t5','oracle','asd123','admin123456','meme','123qwe','qazwsxedc','administrator','superuser','zaq12wsx','121212','654321','ubuntu','0000','zxcvbnm','root@123','1111','vmware','q1w2e3','qwerty123','cisco123','11111111','pa55w0rd','asdfgh','11111','123abc','asdf','centos','888888','54321','password123'); #100ish bad passwords (modified slightly) - https://github.com/WillieStevenson/top-100-passwords/blob/master/password-list.txt

$Global:HighGroups = @('IT admin','CISO');
$Global:MidGroups = @('Management', 'Executives');
$Global:NormalGroups = @('Exploration','Engineering','Accounting', 'HR');
$Global:BadACL = @('GenericAll','GenericWrite','WriteOwner','WriteDACL','Self','WriteProperty');
$Global:ServicesAccountsAndSPNs = @('mssql_svc,mssqlserver','http_svc,httpserver');
$Global:CreatedUsers = @();
$Global:AllObjects = @();
$Global:Domain = "";

#Strings 
$Global:Spacing = "`t"
$Global:PlusLine = "`t[+]"
$Global:ErrorLine = "`t[-]"
$Global:InfoLine = "`t[*]"
function Write-Good { param( $String ) Write-Host $Global:PlusLine  $String -ForegroundColor 'Green'}
function Write-Bad  { param( $String ) Write-Host $Global:ErrorLine $String -ForegroundColor 'red'  }
function Write-Info { param( $String ) Write-Host $Global:InfoLine $String -ForegroundColor 'gray' }
function ShowBanner {
    $banner  = @()
    $banner+= $Global:Spacing + ''
    $banner+= $Global:Spacing + 'VulnAD - Vulnerable Active Directory'
    $banner+= $Global:Spacing + ''                                                  
    $banner | foreach-object {
        Write-Host $_ -ForegroundColor (Get-Random -Input @('Green','Cyan','Yellow','gray','white'))
    }                             
}
function VulnAD-GetRandom {
   Param(
     [array]$InputList
   )
   return Get-Random -InputObject $InputList
}


function VulnAD-AddADGroup {
    Param(
        [array]$GroupList,
	[int]$GroupNumber = 5

    )
    foreach ($group in $GroupList) {
        Write-Info "Creating $group Group"
        Try { New-ADGroup -name $group -GroupScope Global } Catch {}
        for ($i=1; $i -le $GroupNumber; $i=$i+1 ) {
            $randomuser = (VulnAD-GetRandom -InputList $Global:CreatedUsers)
            Write-Info "Adding $randomuser to $group"
            Try { Add-ADGroupMember -Identity $group -Members $randomuser } Catch {}
        }
        $Global:AllObjects += $group;
    }
}
function VulnAD-AddADUser {
    Param(
        [int]$limit = 1
    )
    Add-Type -AssemblyName System.Web
    for ($i=1; $i -le $limit; $i=$i+1 ) {
        $firstname = (VulnAD-GetRandom -InputList $Global:FirstNames);
        $lastname = (VulnAD-GetRandom -InputList $Global:LastNames);
        $fullname = "{0} {1}" -f ($firstname , $lastname);
        $SamAccountName = ("{0}.{1}" -f ($firstname, $lastname)).ToLower();
        $principalname = "{0}.{1}" -f ($firstname, $lastname);
	$password = (VulnAD-GetRandom -InputList $Global:BadPasswords); #$generated_password = ([System.Web.Security.Membership]::GeneratePassword(12,2))
	Write-Info "Creating $SamAccountName User with password: $password"
        Try { New-ADUser -Name "$firstname $lastname" -GivenName $firstname -Surname $lastname -SamAccountName $SamAccountName -UserPrincipalName $principalname@$Global:Domain -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru | Enable-ADAccount } Catch {}
        $Global:CreatedUsers += $SamAccountName;
    }

}
function VulnAD-AddACL {
        [CmdletBinding()]
        param(
            [Parameter(Mandatory=$true)]
            [ValidateNotNullOrEmpty()]
            [string]$Destination,

            [Parameter(Mandatory=$true)]
            [ValidateNotNullOrEmpty()]
            [System.Security.Principal.IdentityReference]$Source,

            [Parameter(Mandatory=$true)]
            [ValidateNotNullOrEmpty()]
            [string]$Rights

        )
        $ADObject = [ADSI]("LDAP://" + $Destination)
        $identity = $Source
        $adRights = [System.DirectoryServices.ActiveDirectoryRights]$Rights
        $type = [System.Security.AccessControl.AccessControlType] "Allow"
        $inheritanceType = [System.DirectoryServices.ActiveDirectorySecurityInheritance] "All"
        $ACE = New-Object System.DirectoryServices.ActiveDirectoryAccessRule $identity,$adRights,$type,$inheritanceType
        $ADObject.psbase.ObjectSecurity.AddAccessRule($ACE)
        $ADObject.psbase.commitchanges()
}
function VulnAD-BadAcls {
    foreach ($abuse in $Global:BadACL) {
        $ngroup = VulnAD-GetRandom -InputList $Global:NormalGroups
        $mgroup = VulnAD-GetRandom -InputList $Global:MidGroups
        $DstGroup = Get-ADGroup -Identity $mgroup
        $SrcGroup = Get-ADGroup -Identity $ngroup
        VulnAD-AddACL -Source $SrcGroup.sid -Destination $DstGroup.DistinguishedName -Rights $abuse
        Write-Info "BadACL $abuse $ngroup to $mgroup"
    }
    foreach ($abuse in $Global:BadACL) {
        $hgroup = VulnAD-GetRandom -InputList $Global:HighGroups
        $mgroup = VulnAD-GetRandom -InputList $Global:MidGroups
        $DstGroup = Get-ADGroup -Identity $hgroup
        $SrcGroup = Get-ADGroup -Identity $mgroup
        VulnAD-AddACL -Source $SrcGroup.sid -Destination $DstGroup.DistinguishedName -Rights $abuse
        Write-Info "BadACL $abuse $mgroup to $hgroup"
    }
    for ($i=1; $i -le (Get-Random -Minimum 1 -Maximum 6); $i=$i+1 ) {
        $abuse = (VulnAD-GetRandom -InputList $Global:BadACL);
    
	$randomuser = VulnAD-GetRandom -InputList $Global:CreatedUsers
        $randomgroup = VulnAD-GetRandom -InputList $Global:AllObjects
	
	if ((Get-Random -Maximum 2)){
            $Dstobj = Get-ADUser -Identity $randomuser
            $Srcobj = Get-ADGroup -Identity $randomgroup
        }else{
            $Srcobj = Get-ADUser -Identity $randomuser
            $Dstobj = Get-ADGroup -Identity $randomgroup
        }
        VulnAD-AddACL -Source $Srcobj.sid -Destination $Dstobj.DistinguishedName -Rights $abuse 
        Write-Info "BadACL $abuse $randomuser and $randomgroup"
    }
}
function VulnAD-Kerberoasting {
    $selected_service = (VulnAD-GetRandom -InputList $Global:ServicesAccountsAndSPNs)
    $svc = $selected_service.split(',')[0];
    $spn = $selected_service.split(',')[1];
    $password = VulnAD-GetRandom -InputList $Global:BadPasswords;
    Write-Info "Kerberoasting $svc $spn"
    Try { New-ADServiceAccount -Name $svc -ServicePrincipalNames "$svc/$spn.$Global:Domain" -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -RestrictToSingleComputer -PassThru } Catch {}
    foreach ($sv in $Global:ServicesAccountsAndSPNs) {
        if ($selected_service -ne $sv) {
            $svc = $sv.split(',')[0];
            $spn = $sv.split(',')[1];
            Write-Info "Creating $svc services account"
            $password = ([System.Web.Security.Membership]::GeneratePassword(12,2))
            Try { New-ADServiceAccount -Name $svc -ServicePrincipalNames "$svc/$spn.$Global:Domain" -RestrictToSingleComputer -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru } Catch {}

        }
    }
}
function VulnAD-ASREPRoasting {
    for ($i=1; $i -le (Get-Random -Minimum 1 -Maximum 3); $i=$i+1 ) {
        $randomuser = (VulnAD-GetRandom -InputList $Global:CreatedUsers)
        $password = VulnAD-GetRandom -InputList $Global:BadPasswords;
        Set-AdAccountPassword -Identity $randomuser -Reset -NewPassword (ConvertTo-SecureString $password -AsPlainText -Force)
        Set-ADAccountControl -Identity $randomuser -DoesNotRequirePreAuth 1
        Write-Info "AS-REPRoasting $randomuser"
    }
}
function VulnAD-DnsAdmins {
    for ($i=1; $i -le (Get-Random -Minimum 1 -Maximum 3); $i=$i+1 ) {
        $randomuser = (VulnAD-GetRandom -InputList $Global:CreatedUsers)
        Add-ADGroupMember -Identity "DnsAdmins" -Members $randomuser
        Write-Info "DnsAdmins : $randomuser"
    }
    $randomg = (VulnAD-GetRandom -InputList $Global:MidGroups)
    Add-ADGroupMember -Identity "DnsAdmins" -Members $randomg
    Write-Info "DnsAdmins Nested Group : $randomg"
}
function VulnAD-PwdInObjectDescription {
    for ($i=1; $i -le (Get-Random -Maximum 2); $i=$i+1 ) {
        $randomuser = (VulnAD-GetRandom -InputList $Global:CreatedUsers)
        $password = ([System.Web.Security.Membership]::GeneratePassword(12,2))
        Set-AdAccountPassword -Identity $randomuser -Reset -NewPassword (ConvertTo-SecureString $password -AsPlainText -Force)
        Set-ADUser $randomuser -Description "User Password $password"
        Write-Info "Password in Description : $randomuser"
    }
}
function VulnAD-DefaultPassword {
    for ($i=1; $i -le (Get-Random -Minimum 1 -Maximum 3); $i=$i+1 ) {
        $randomuser = (VulnAD-GetRandom -InputList $Global:CreatedUsers)
        $password = "Changeme123!";
        Set-AdAccountPassword -Identity $randomuser -Reset -NewPassword (ConvertTo-SecureString $password -AsPlainText -Force)
        Set-ADUser $randomuser -Description "New User ,DefaultPassword"
        Set-AdUser $randomuser -ChangePasswordAtLogon $true
        Write-Info "Default Password : $randomuser"
    }
}
function VulnAD-PasswordSpraying {
    $same_password = "ncc1701";
    for ($i=1; $i -le (Get-Random -Maximum 4); $i=$i+1 ) {
        $randomuser = (VulnAD-GetRandom -InputList $Global:CreatedUsers)
        Set-AdAccountPassword -Identity $randomuser -Reset -NewPassword (ConvertTo-SecureString $same_password -AsPlainText -Force)
        Set-ADUser $randomuser -Description "Shared User"
        Write-Info "Same Password (Password Spraying) : $randomuser"
    }
}
function VulnAD-DCSync {
    for ($i=1; $i -le (Get-Random -Maximum 3); $i=$i+1 ) {
        $ADObject = [ADSI]("LDAP://" + (Get-ADDomain $Global:Domain).DistinguishedName)
        $randomuser = (VulnAD-GetRandom -InputList $Global:CreatedUsers)
        $sid = (Get-ADUser -Identity $randomuser).sid

        $objectGuidGetChanges = New-Object Guid 1131f6aa-9c07-11d1-f79f-00c04fc2dcd2
        $ACEGetChanges = New-Object DirectoryServices.ActiveDirectoryAccessRule($sid,'ExtendedRight','Allow',$objectGuidGetChanges)
        $ADObject.psbase.Get_objectsecurity().AddAccessRule($ACEGetChanges)

        $objectGuidGetChanges = New-Object Guid 1131f6ad-9c07-11d1-f79f-00c04fc2dcd2
        $ACEGetChanges = New-Object DirectoryServices.ActiveDirectoryAccessRule($sid,'ExtendedRight','Allow',$objectGuidGetChanges)
        $ADObject.psbase.Get_objectsecurity().AddAccessRule($ACEGetChanges)

        $objectGuidGetChanges = New-Object Guid 89e95b76-444d-4c62-991a-0facbeda640c
        $ACEGetChanges = New-Object DirectoryServices.ActiveDirectoryAccessRule($sid,'ExtendedRight','Allow',$objectGuidGetChanges)
        $ADObject.psbase.Get_objectsecurity().AddAccessRule($ACEGetChanges)
        $ADObject.psbase.CommitChanges()

        Set-ADUser $randomuser -Description "Replication Account"
        Write-Info "Giving DCSync to : $randomuser"
    }
}
function VulnAD-DisableSMBSigning {
    Set-SmbClientConfiguration -RequireSecuritySignature 0 -EnableSecuritySignature 0 -Confirm -Force
}
function Invoke-VulnAD {
    Param(
        [int]$UsersLimit = 16,
        [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True,Position=1)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $DomainName
    )
    ShowBanner
    $Global:Domain = $DomainName
    Set-ADDefaultDomainPasswordPolicy -Identity $Global:Domain -LockoutDuration 00:01:00 -LockoutObservationWindow 00:01:00 -ComplexityEnabled $false -ReversibleEncryptionEnabled $False -MinPasswordLength 4
    VulnAD-AddADUser -limit $UsersLimit
    Write-Good "Users Created"
    VulnAD-AddADGroup -GroupList $Global:HighGroups -GroupNumber 2
    Write-Good "$Global:HighGroups Groups Created"
    VulnAD-AddADGroup -GroupList $Global:MidGroups -GroupNumber 5
    Write-Good "$Global:MidGroups Groups Created"
    VulnAD-AddADGroup -GroupList $Global:NormalGroups -GroupNumber 8
    Write-Good "$Global:NormalGroups Groups Created" 
    VulnAD-BadAcls
    Write-Good "BadACL Done"
    VulnAD-Kerberoasting
    Write-Good "Kerberoasting Done"
    VulnAD-ASREPRoasting
    Write-Good "AS-REPRoasting Done"
    VulnAD-DnsAdmins
    Write-Good "DnsAdmins Done"
    VulnAD-PwdInObjectDescription
    Write-Good "Password In Object Description Done"
    VulnAD-DefaultPassword
    Write-Good "Default Password Done"
    VulnAD-PasswordSpraying
    Write-Good "Password Spraying Done"
    VulnAD-DCSync
    Write-Good "DCSync Done"
    VulnAD-DisableSMBSigning
    Write-Good "SMB Signing Disabled"
}

Invoke-VulnAD -DomainName "sgv.org"


