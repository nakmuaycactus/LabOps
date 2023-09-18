packer {
  required_plugins {
    vsphere = {
      source  = "github.com/hashicorp/vsphere"
      version = "~> 1"
    }
  }
}

variable "vcenter_server" {default="192.168.3.156"}
variable "host" {default="localhost.localdomain"}
variable "username" {default="administrator@vsphere.local"}
variable "password" {default="Thrunters1!FTW"}
variable "insecure_connection" {default=true}
variable "datastore" {default="packer-testing"}
variable "network" {default="VM Network"}
variable "network_card" {default="vmxnet3"}
variable "vm_name" {default="New VM"}
variable "guest_os_type" {}
variable "iso_paths" {}
variable "CPUs" {default=8}
variable "RAM" {default=16384}
variable "RAM_reserve_all" {default=true}
variable "disk_controller_type" {default=["pvscsi"]}
variable "disk_size" {default=51200}
variable "disk_thin_provisioned" {default=true}
variable "ssh_username" {default="packer"}
variable "ssh_password" {default="packer"}
variable "floppy_files" {default=null}
variable "output_directory" {default="output/misc"}
variable "boot_command" {}

source "vsphere-iso" "windows" {
  CPUs                 = var.CPUs
  RAM                  = var.RAM
  RAM_reserve_all      = var.RAM_reserve_all
  boot_command         = var.boot_command
  communicator         = "ssh"
  ssh_username         = var.ssh_username
  ssh_password         = var.ssh_password
  ssh_timeout          = "1h"
  ssh_clear_authorized_keys = "true"
  shutdown_timeout     = "15m"
 
  datastore            = var.datastore
  disk_controller_type = var.disk_controller_type
  floppy_files 	       = var.floppy_files
    # floppy_files         = ["${path.root}/setup/"] 
  floppy_img_path      = var.floppy_img_path
  guest_os_type        = var.guest_os_type
  host                 = var.host
  insecure_connection  = var.insecure_connection
  iso_paths            = var.iso_paths
  network_adapters {
    network      = var.network
    network_card = var.network_card
  }
  password = var.password
  storage {
    disk_size             = var.disk_size
    disk_thin_provisioned = var.disk_thin_provisioned
  }
  username       = var.username
  vcenter_server = var.vcenter_server
  vm_name        = var.vm_name
 
  ip_settle_timeout = "12m"

  export {
    force                 = true
    output_directory      = var.output_directory
  }
}

build {
  sources = ["source.vsphere-iso.windows"]

  provisioner "windows-shell" {
    inline = ["dir c:\\"]
  }
}
