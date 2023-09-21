vm_name             = "alphaSer-22"
guest_os_type       = "windows9_64Guest"
iso_paths           = ["[AD-VMs] ISOs/win-10-usa.iso", "[AD-VMs] ISOs/windows.iso"]
CPUs                = 4
floppy_files        = ["http/ser-22-setup/"]
floppy_img_path     = "[AD-VMs] ISOs/pvscsi-Windows8.flp"
output_directory    = "../output/ser-22"
boot_command        = ["<wait1m10s>", "<tab><tab><tab>", "<enter>", "<wait10m>","<enter>", "<wait5s>","<enter>", "<wait5s>", "<enter>"]