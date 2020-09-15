`sudo apt install system76-driver-nvidia`

edit `/usr/lib/modprobe.d/nvidia-graphics-drivers.conf`

and comment out `nvidia-drm modeset=1`

run `sudo update-initramfs -u`

reboot
