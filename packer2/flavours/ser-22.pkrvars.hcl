vcenter_server      = "192.168.3.156"
host                = "localhost.localdomain"
username            = "administrator@vsphere.local"
password            = "Thrunters1!FTW"
insecure_connection = true
datastore           = "packer-testing"
iso_paths           = ["[AD-VMs] ISOs/win-10-usa.iso", "[AD-VMs] ISOs/windows.iso"]
network             = "VM Network"
network_card        = "vmxnet3"
vm_name             = "alphaSer-22"
guest_os_type       = "windows9_64Guest"
CPUs                = 4
RAM                 = 16384
RAM_reserve_all     = true
disk_controller_type = ["pvscsi"]
disk_size           = 51200
disk_thin_provisioned = true
ssh_username        = "packer"
ssh_password        = "packer"
floppy_files        = ["http/ser-22-setup/"]
floppy_img_path     = "[AD-VMs] ISOs/pvscsi-Windows8.flp"
output_directory    = "../output/ser-22"
boot_command        = ["<wait1m10s>", "<tab><tab><tab>", "<enter>", "<wait10m>","<enter>", "<wait5s>","<enter>", "<wait5s>", "<enter>"]
