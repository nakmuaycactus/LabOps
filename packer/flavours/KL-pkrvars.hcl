vm_name          = "alphaKL"  
guest_os_type    = "debian6_64Guest" 
#iso_paths       = ["[AD-VMs] ISOs/kali-linux-2023.2a-installer-amd64.iso"]  
iso_url		     = "https://cdimage.kali.org/kali-2023.3/kali-linux-2023.3-installer-amd64.iso"
iso_checksum	 = "ffe5aa3932397895257252a144f9c62f2b8663f6b3f8bcf120b5ae53045d6031"
ssh_username     = "packer"
ssh_password     = "packer"
output_directory = "../output/KL"
boot_command     = ["<wait><wait><wait><esc><wait>", "/install.amd/vmlinuz ", "initrd=/install.amd/initrd.gz ",  
                    "priority=critical ", "locale=en_US ", "netcfg/choose_interface=eth0 ", "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/KL-preseed.cfg ", 
                    " netcfg/disable_dhcp=true netcfg/confirm_static=true netcfg/get_ipaddress=192.168.3.154 netcfg/get_netmask=255.255.255.0 ",
                    " netcfg/get_gateway=192.168.3.1 netcfg/get_nameservers=8.8.8.8 ",
                    "auto ", "interface=auto ", "keymap=us ", "hostname=kali ", "domain=localdomain ",  "-- <wait> ", "<enter><wait>"]
