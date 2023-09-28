vm_name          = "alphaUL"  
guest_os_type    = "ubuntu64Guest"
#iso_paths        = ["[AD-VMs] ISOs/ubuntu-16.04.7-server-amd64.iso"]
iso_url          = "https://releases.ubuntu.com/16.04/ubuntu-16.04.7-server-amd64.iso"
iso_checksum	 = "file:http://releases.ubuntu.com/16.04/SHA256SUMS"
ssh_username     = "packer"
ssh_password     = "packer"
floppy_files     = ["http/UL-preseed.cfg"]
output_directory = "../output/UL"
provisioner_type = "shell"
boot_command     = ["<enter><wait><f6><wait><esc><wait>",
                    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                    "<bs><bs><bs>", "/install/vmlinuz initrd=/install/initrd.gz",
                    " priority=critical locale=en_US netcfg/choose_interface=eth0", 
                    " file=/media/UL-preseed.cfg <enter>"]
