vm_name             = "alphaSer-16"
guest_os_type       = "windows9_64Guest"
iso_paths           = ["[AD-VMs] ISOs/win-server-2016.ISO", "[AD-VMs] ISOs/windows.iso"] # windows.iso is vm tools
CPUs                = 8
floppy_files        = ["http/ser-16-setup/"]
floppy_img_path     = "[AD-VMs] ISOs/pvscsi-Windows8.flp"
output_directory   = "../output/ser-16"
boot_command       = ["<wait1m10s>", "<tab><tab><tab>", "<enter>"]