vcenter_server      = "192.168.3.150"
host                = "localhost.localdomain"
username            = "root"
password            = "Thrunters1!FTW"
insecure_connection = true
datastore           = "packer-testing"
iso_paths           = ["[AD-VMs] ISOs/win-server-2016.ISO", "[AD-VMs] ISOs/windows.iso"] # windows.iso is vm tools
network             = "VM Network"
network_card        = "vmxnet3"
vm_name             = "ser-16"
guest_os_type       = "windows9_64Guest"
CPUs                = 8
RAM                 = 16384
RAM_reserve_all     = true
disk_controller_type = ["pvscsi"]
disk_size           = 51200
disk_thin_provisioned = true
ssh_username      = "packer"
ssh_password      = "packer"
floppy_files        = ["setup/ser-16-setup/"]
floppy_img_path     = "[AD-VMs] ISOs/pvscsi-Windows8.flp"
output_directory   = "./output/ser-16"
boot_command       = ["<wait1m10s>", "<tab><tab><tab>", "<enter>"]
