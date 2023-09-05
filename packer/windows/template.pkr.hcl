packer {
  required_plugins {
    vsphere = {
      source  = "github.com/hashicorp/vsphere"
      version = "~> 1"
    }
  }
}

variable "CPUs" {}
variable "RAM" {}
variable "RAM_reserve_all" {}
variable "boot_command" {}
variable "datastore" {}
variable "disk_controller_type" {}
variable "floppy_img_path" {}
variable "guest_os_type" {}
variable "host" {}
variable "insecure_connection" {}
variable "iso_paths" {}
variable "network" {}
variable "network_card" {}
variable "password" {}
variable "disk_size" {}
variable "disk_thin_provisioned" {}
variable "username" {}
variable "vcenter_server" {}
variable "vm_name" {}
variable "output_directory" {}
variable "ssh_username" {}
variable "ssh_password" {}
variable "floppy_files" {}

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
