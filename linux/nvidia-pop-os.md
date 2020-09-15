`sudo apt install system76-driver-nvidia`

edit `/usr/lib/modprobe.d/nvidia-graphics-drivers.conf`

and comment out `nvidia-drm modeset=1`

run `sudo update-initramfs -u`

Reboot. After the reboot, check whether `sudo cat /sys/module/nvidia_drm/parameters/modeset` outputs a `N`.
