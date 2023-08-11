#ESXI Settings
  vcenter_server        = "192.168.3.150" 
  host                  = "localhost.localdomain"
  username              = "root"
  password              = "Thrunters1!FTW"
  insecure_connection   = true
  datastore             = "AD-VMs"
  network               = "VM Network"
  network_card          = "vmxnet3"

#Created VM Config
  vm_name               = "pkrKL"  
  guest_os_type         = "debian8_64Guest" 
  iso_paths             = ["[AD-VMs] ISOs/kali-linux-2023.2a-installer-amd64.iso"]  
  CPUs                  = 4
  RAM                   = 8192
  RAM_reserve_all       = true
  disk_controller_type  = ["pvscsi"]
  disk_size             = 32768
  disk_thin_provisioned = true
  ssh_username          = "packer"
  ssh_password          = "packer"  
# floppy_files          = [""]
  output_directory      = "./output/KL"
#  boot_command          = ["<tab><bs><bs><bs><bs><bs>","inst.text ip=192.168.3.156:255.255.255.0::eth0:none nameserver=8.8.8.8 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg","<enter>"]
boot_command = [
#"<esc> ip=192.168.3.156:255.255.255.0::eth0:none nameserver=8.8.8.8", 
        "<esc><wait>",
        "install <wait>",
        " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/KL-preseed.cfg",
        " debian-installer=en_US.UTF-8 auto locale=en_US.UTF-8 netcfg/choose_interface=eth0 ",
        " kbd-chooser/method=us keyboard-configuration/xkb-keymap=us ",
#        " netcfg/get_hostname={{ .Name }} netcfg/get_domain=vagrantup.com ",
        " fb=false debconf/frontend=noninteractive console-setup/ask_detect=false ",
        " console-keymaps-at/keymap=us grub-installer/bootdev=/dev/sda netcfg/disable_dhcp=true<enter>"]
