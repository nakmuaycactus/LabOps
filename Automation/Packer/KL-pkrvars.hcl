#ESXI Settings
  vcenter_server        = "192.168.3.150" 
  host                  = "localhost.localdomain"
  username              = "root"
  password              = "Thrunters1!FTW"
  insecure_connection   = true
  datastore             = "AD-VMs"
  network               = "VM Network"
  network_card          = "vmxnet3"

#Created VM Config
  vm_name               = "pkr_KL"  
  guest_os_type         = "Centos64Guest" 
  iso_paths             = ["[AD-VMs] ISOs/kali-linux-2023.2a-installer-amd64.iso"]  
  CPUs                  = 4
  RAM                   = 8192
  RAM_reserve_all       = true
  disk_controller_type  = ["pvscsi"]
  disk_size             = 32768
  disk_thin_provisioned = true
  ssh_username          = "packer"
  ssh_password          = "packer"  
# floppy_files          = [""]
  output_directory      = "./output/KL"
  boot_command          = ["<tab><bs><bs><bs><bs><bs>","inst.text ip=192.168.3.156:255.255.255.0::eth0:none nameserver=8.8.8.8 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg","<enter>"]
