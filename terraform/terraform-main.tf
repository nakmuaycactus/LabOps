provider "vsphere" {
  user                 = "root"
  password             = "Thrunters1!FTW"
  vsphere_server       = "192.168.3.150"
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
 name = "ha-datacenter"
}

data "vsphere_resource_pool" "pool" {}

data "vsphere_datastore" "your_datastore" {
 name = "packer-testing"
 datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "your_network" {
 name = "VM Network"
 datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm" {
 ip_address_start = "192.168.3.156" 

  name                 = "pkrUL"
  resource_pool_id     = "${data.vsphere_resource_pool.pool.id}"
  datastore_id         = "${data.vsphere_datastore.your_datastore.id}"
  num_cpus             = 4
  memory               = 8192
  guest_id             = "ubuntu64Guest"
  wait_for_guest_net_timeout = 15
  disk {
    label              = "disk0"
    size               = "20"
    path               = "[packer-testing] output/UL/pkrUL-0.vmdk"
    thin_provisioned   = true
  }
  network_interface { 
    network_id         = "${data.vsphere_network.your_network.id}"
    adapter_type = "vmxnet3"  
  }
}
