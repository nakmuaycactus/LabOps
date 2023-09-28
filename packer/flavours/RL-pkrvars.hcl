vm_name          = "alphaRL"
guest_os_type    = "Centos64Guest" 
#iso_paths       = ["[AD-VMs] ISOs/Rocky-9.2-x86_64-dvd.iso"]  
iso_url			 = "https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.2-x86_64-dvd.iso"
iso_checksum     = "cd43bb2671472471b1fc0a7a30113dfc9a56831516c46f4dbd12fb43bb4286d2"
ssh_username     = "packer"
ssh_password     = "packer"
output_directory = "../output/RL"
boot_command	 = ["<tab><bs><bs><bs><bs><bs>","inst.cmdline ip=192.168.3.152:255.255.255.0:eth0:none nameserver=8.8.8.8 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/RL-ks.cfg","<enter>"]
