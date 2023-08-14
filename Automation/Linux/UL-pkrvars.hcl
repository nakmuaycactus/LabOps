vm_name          = "pkrUL"  
guest_os_type    = "ubuntu64Guest"
iso_paths        = ["[AD-VMs] ISOs/ubuntu-16.04.7-server-amd64.iso"]
floppy_files     = ["http/UL-preseed.cfg"]
output_directory = "./output/UL"
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