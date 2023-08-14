  vm_name               = "pkrRL"  
  guest_os_type         = "Centos64Guest" 
  iso_paths             = ["[AD-VMs] ISOs/Rocky-9.2-x86_64-dvd.iso"]  
  output_directory      = "./output/RL"
  boot_command          = ["<tab><bs><bs><bs><bs><bs>","inst.cmdline ip=192.168.3.156:255.255.255.0::eth0:none nameserver=8.8.8.8 inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/RL-ks.cfg","<enter>"]