## Configure the vSphere Provider
provider "vsphere" {
    vsphere_server = "${var.vsphere_server}"
    user = "${var.vsphere_user}"
    password = "${var.vsphere_password}"
    allow_unverified_ssl = true
}

## Build VM
data "vsphere_datacenter" "dc" {
  name = "ha-datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "packer-testing"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {}

data "vsphere_network" "mgmt_lan" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "test2" {
  name             = "test2"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus   = 1
  memory     = 2048
  wait_for_guest_net_timeout = 0
  guest_id = "ubuntu64Guest"
  nested_hv_enabled =true
  network_interface {
   network_id     = "${data.vsphere_network.mgmt_lan.id}"
   adapter_type   = "vmxnet3"
  }

  disk {
   size             = 16
   label            = "test2.vmdk"
   eagerly_scrub    = false
   thin_provisioned = true
  }
}
