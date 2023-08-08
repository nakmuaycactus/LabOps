#ESXI Settings
variable "vcenter_server" {}
variable "host" {}
variable "username" {}
variable "password" {}
variable "insecure_connection" {}
variable "datastore" {}
variable "iso_paths" {}
variable "network" {}
variable "network_card" {}
variable "vm_name" {}
variable "guest_os_type" {}
variable "CPUs" {}
variable "RAM" {}
variable "RAM_reserve_all" {}
variable "disk_controller_type" {}
variable "disk_size" {}
variable "disk_thin_provisioned" {}
variable "ssh_username" {}
variable "ssh_password" {}
variable "floppy_files" {}
variable "boot_command" {}
variable "output_directory" {}

source "vsphere-iso" "ubuntu-16-04" {
  vcenter_server          = var.vcenter_server
  username                = var.username
  password                = var.password
  insecure_connection     = var.insecure_connection
 
  vm_name                 = var.vm_name
  host                    = var.host
  datastore               = var.datastore
  iso_paths               = var.iso_paths
 
  CPUs                    = var.CPUs
  RAM                     = var.RAM
  RAM_reserve_all         = var.RAM_reserve_all
  disk_controller_type    = var.disk_controller_type
  storage {
    disk_size             = var.disk_size
    disk_thin_provisioned = var.disk_thin_provisioned
  }
  floppy_files            = var.floppy_files
  guest_os_type           = var.guest_os_type
  network_adapters {
    network               = var.network
    network_card          = var.network_card
  }
 
  boot_command            = var.boot_command
 
  ssh_username            = var.ssh_username
  ssh_password            = var.ssh_password
 
  export {
    force                 = true
    output_directory      = var.output_directory
  }
}
 
build {
 sources = ["source.vsphere-iso.ubuntu-16-04"]
 
  provisioner "shell" {
    inline = ["ls /"]
  }
}
 
