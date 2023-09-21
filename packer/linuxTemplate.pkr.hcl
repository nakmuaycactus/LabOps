packer {
  required_plugins {
    vsphere = {
      source = "github.com/hashicorp/vsphere"
      version = "~> 1"
    }
  }
}

variable "vcenter_server" {default="192.168.3.156"}
variable "host" {default="localhost.localdomain"}
variable "username" {default="administrator@vsphere.local"}
variable "password" {default="Thrunters1!FTW"}
variable "insecure_connection" {default=true}
variable "datastore" {default="AD-VMs"}
variable "network" {default="VM Network"}
variable "network_card" {default="vmxnet3"}
variable "vm_name" {default="New VM"}
variable "guest_os_type" {}
#variable "iso_paths" {default=[""]}
variable "iso_url" {default=""}
variable "iso_checksum" {default=""}
variable "CPUs" {default=4}
variable "RAM" {default=8192}
variable "RAM_reserve_all" {default=true}
variable "disk_controller_type" {default=["pvscsi"]}
variable "disk_size" {default=32768}
variable "disk_thin_provisioned" {default=true}
variable "ssh_username" {default="packer"}
variable "ssh_password" {default="packer"}
variable "http_ip" {default="192.168.3.157"}
variable "http_directory" {default="http"}
variable "floppy_files" {default=null}
variable "output_directory" {default="output/misc"}
variable "boot_command" {}

source "vsphere-iso" "linux" {
  vcenter_server          = var.vcenter_server
  username                = var.username
  password                = var.password
  insecure_connection     = var.insecure_connection
  vm_name                 = var.vm_name
  host                    = var.host
  guest_os_type           = var.guest_os_type
  datastore               = var.datastore
 # iso_paths               = var.iso_paths
  iso_url                 = var.iso_url
  iso_checksum            = var.iso_checksum
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
    inline = [
      "ls /",
      "mkdir -p ~/.ssh",
      "echo 'AAAAB3NzaC1yc2EAAAADAQABAAABgQDtEdTk+/VatzeMbHdZ0oUvYQmBgvzMbwr9oZDpOYDo9f+HDWHoG6RxtXUtpZ3JH6ENvMLDFIIOrJ2NXXzMuSxBJpUdT5KvIDJB3FBK4RYSr/be8oW1+eunlnlW03xU7zl8EZCd+y+QSx1dTJqsHCC0usV445xyKxiDaG/V9W6RLtvFHBmgyE/WseJhg0AKzlSTtes11PGgmpg/spYIZVNjTFnfbqbscmWnzf3TjkvAgzJEDTpfhvuA+H3RpBTgX0bp+O1xeQKy1DtZlBH5/3Wu4Tq5ToUPoCp9zihGR12izmJe8kbLANlHn8vIjeXLIlSePSbMQaGyLM5JH45I2SOrP/37xG/JIeKVoOMkBAcTaffsSw2hsi1vPkiMa1nA0m+Q5jsz3PEn8AOUykqU62eogKMpKh9PrjoaiEqNpEGRzKyB34ixQnPX2p7kLRAEfKJZhINFc5kCX/uyyZ/gdC2fkqofq4e66pkMpdIBHJw2lSzLykuWbbqzvp9Gd/nUOx8=' >> ~/.ssh/authorized_keys",
      "chmod 600 ~/.ssh/authorized_keys"
    ]
  }
}
 
