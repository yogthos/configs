    sudo apt-get update
    sudo apt-get --reinstall install bcmwl-kernel-source

    sudo modprobe -r b43 ssb wl brcmfmac brcmsmac bcma
    sudo modprobe wl
