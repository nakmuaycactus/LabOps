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
variable "boot_command" {}
variable "output_directory" {}
variable "http_ip" {default = "192.168.3.157"}
variable "http_directory" {default = "http"}
variable "floppy_files" {default = null}

source "vsphere-iso" "linux" {
  vcenter_server          = var.vcenter_server
  username                = var.username
  password                = var.password
  insecure_connection     = var.insecure_connection
  vm_name                 = var.vm_name
  host                    = var.host
  guest_os_type           = var.guest_os_type
  datastore               = var.datastore
  iso_paths               = var.iso_paths
  http_directory          = var.http_directory
  http_ip                 = var.http_ip
  floppy_files            = var.floppy_files
  ssh_username            = var.ssh_username
  ssh_password            = var.ssh_password
  boot_command            = var.boot_command
  CPUs                    = var.CPUs
  RAM                     = var.RAM
  RAM_reserve_all         = var.RAM_reserve_all
  disk_controller_type    = var.disk_controller_type
  storage {
    disk_size             = var.disk_size
    disk_thin_provisioned = var.disk_thin_provisioned
  }
  network_adapters {
    network               = var.network
    network_card          = var.network_card
  }
  export {
    force                 = true
    output_directory      = var.output_directory
  }
}
 
build {
 sources = ["source.vsphere-iso.linux"]
 
  provisioner "shell" {
    inline = ["ls /"]
  }
}
 
