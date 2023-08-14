Set-ExecutionPolicy -ExecutionPolicy Bypass

$IP = "192.168.3.156"
$MaskBits = 24 # This means subnet mask = 255.255.255.0
$Gateway = "192.168.3.1"
$Dns = "1.1.1.1"
$IPType = "IPv4"

# Retrieve the network adapter that you want to configure
$adapter = Get-NetAdapter | ? {$_.Status -eq "up"}

# Remove any existing IP, gateway from our ipv4 adapter
If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
 $adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
}

If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
 $adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
}

# Configure the IP address and default gateway
$adapter | New-NetIPAddress `
 -AddressFamily $IPType `
 -IPAddress $IP `
 -PrefixLength $MaskBits `
 -DefaultGateway $Gateway

# Configure the DNS client server IP addresses
$adapter | Set-DnsClientServerAddress -ServerAddresses $DNS

# disable priv fw
# set-netfirewallprofile -profile private,public -enabled False

# bypass pop up
Set-NetConnectionProfile -Name "NetworkName" -NetworkCategory Private

# 2016 server has to set up openssh """manually""" like this
# can just use handy dandy cmdlet like the rest, bc that'd be too easy
$DownloadPath = "C:\Users\packer\Downloads\OpenSSH-Win64.zip"

# tls error if u dont include the next line
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# downloads from a github repo
iwr -uri https://github.com/PowerShell/Win32-OpenSSH/releases/download/v9.2.2.0p1-Beta/OpenSSH-Win64.zip -OutFile $DownloadPath

# extract zip
$ExtractPath = "C:\Program Files\OpenSSH"
Expand-Archive -Path $DownloadPath -DestinationPath $ExtractPath -Force

# add openssh to path
$env:Path += ";$ExtractPath"
# direct invocation for install bc i had to
Set-ExecutionPolicy Bypass
& "$ExtractPath\OpenSSH-Win64\install-sshd.ps1"

# generate host key
Start-Process "$ExtractPath\OpenSSH-Win64\ssh-keygen.exe" -ArgumentList "-A" -Wait

# set sshd service startup to auto and start it
Set-Service -Name sshd -StartupType 'Automatic'
Start-Service sshd

# fw rules
New-NetFirewallRule -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22


