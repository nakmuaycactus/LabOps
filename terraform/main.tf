## Configure the vSphere Provider
provider "vsphere" {
  vsphere_server       = "192.168.3.156"
  user                 = "administrator@vsphere.local"
  password             = "Thrunters1!FTW"
  allow_unverified_ssl = true
}

## Build VM
data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "packer-testing"
  datacenter_id = data.vsphere_datacenter.dc.id
}

#data "vsphere_compute_cluster" "cluster" {
#  name          = "cluster-01"
#  datacenter_id = "${data.vsphere_datacenter.dc.id}"
#}

data "vsphere_resource_pool" "pool" {
  name          = "Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
  name          = "192.168.3.150"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "ubuntuVM" {
  name             = "ubuntuVM"
  datacenter_id    = data.vsphere_datacenter.dc.id
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  host_system_id   = data.vsphere_host.host.id

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  ovf_deploy {
    allow_unverified_ssl_cert = true
    local_ovf_path            = "../output/UL/packerUL.ovf"
    disk_provisioning         = "thin"
    ip_protocol               = "IPV4"
    ip_allocation_policy      = "STATIC_MANUAL"
    ovf_network_map = {
      "Network 1" = data.vsphere_network.network.id
      "Network 2" = data.vsphere_network.network.id
    }
  }

  vapp {
    properties = {
      "guestinfo.hostname" = "ubuntuVM",
      #"guestinfo.ipaddress"    = "192.168.3.152",
      #"guestinfo.netmask"      = "255.255.255.0",
      #"guestinfo.gateway"      = "192.168.3.1",
      #"guestinfo.dns"          = "8.8.8.8",
      "guestinfo.domain"   = "example.com",
      "guestinfo.ntp"      = "ntp.example.com",
      "guestinfo.password" = "Thrunters1!FTW",
      "guestinfo.ssh"      = "True"
    }
  }
}

resource "vsphere_virtual_machine" "kaliVM" {
  name             = "kaliVM"
  datacenter_id    = data.vsphere_datacenter.dc.id
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  host_system_id   = data.vsphere_host.host.id

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  ovf_deploy {
    allow_unverified_ssl_cert = true
    local_ovf_path            = "../output/KL/packerKL.ovf"
    disk_provisioning         = "thin"
    ip_protocol               = "IPV4"
    ip_allocation_policy      = "STATIC_MANUAL"
    ovf_network_map = {
      "Network 1" = data.vsphere_network.network.id
      "Network 2" = data.vsphere_network.network.id
    }
  }

  vapp {
    properties = {
      "guestinfo.hostname" = "kaliVM",
      #"guestinfo.ipaddress"    = "192.168.3.153",
      #"guestinfo.netmask"      = "255.255.255.0",
      #"guestinfo.gateway"      = "192.168.3.1",
      #"guestinfo.dns"          = "8.8.8.8",
      "guestinfo.domain"   = "example.com",
      "guestinfo.ntp"      = "ntp.example.com",
      "guestinfo.password" = "Thrunters1!FTW",
      "guestinfo.ssh"      = "True"
    }
  }
}


resource "vsphere_virtual_machine" "rockyVM" {
  name             = "rockyVM"
  datacenter_id    = data.vsphere_datacenter.dc.id
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  host_system_id   = data.vsphere_host.host.id

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  ovf_deploy {
    allow_unverified_ssl_cert = true
    local_ovf_path            = "../output/RL/packerRL.ovf"
    disk_provisioning         = "thin"
    ip_protocol               = "IPV4"
    ip_allocation_policy      = "STATIC_MANUAL"
    ovf_network_map = {
      "Network 1" = data.vsphere_network.network.id
      "Network 2" = data.vsphere_network.network.id
    }
  }

  vapp {
    properties = {
      "guestinfo.hostname" = "rockyVM",
      #"guestinfo.ipaddress"    = "192.168.3.154",
      #"guestinfo.netmask"      = "255.255.255.0",
      #"guestinfo.gateway"      = "192.168.3.1",
      #"guestinfo.dns"          = "8.8.8.8",
      "guestinfo.domain"   = "example.com",
      "guestinfo.ntp"      = "ntp.example.com",
      "guestinfo.password" = "Thrunters1!FTW",
      "guestinfo.ssh"      = "True"
    }
  }
}
