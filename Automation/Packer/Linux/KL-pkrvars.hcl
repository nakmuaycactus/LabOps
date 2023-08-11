vm_name           = "pkrKL"
guest_os_type    = "debian8_64Guest"
iso_paths        = ["[AD-VMs] ISOs/kali-linux-2023.2a-installer-amd64.iso"]
output_directory = "./output/KL"
boot_command     = ["<esc><wait> install <wait>",
                    " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/KL-preseed.cfg",
                    " debian-installer=en_US.UTF-8 auto locale=en_US.UTF-8 netcfg/choose_interface=eth0 ",
                    " kbd-chooser/method=us keyboard-configuration/xkb-keymap=us ",
                    " fb=false debconf/frontend=noninteractive console-setup/ask_detect=false ",
                    " console-keymaps-at/keymap=us grub-installer/bootdev=/dev/sda netcfg/disable_dhcp=true<enter>"]
