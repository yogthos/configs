getting sleep to work

from https://github.com/pop-os/pop/issues/349

https://fueledonbacon.com/popos-20-04-fix-wake-from-suspend-and-with-keyboard/

    sudo kernelstub -o "loglevel=0 splash systemd.show_status=false quiet mem_sleep_default=deep"
    
working sleep on iMac


```
sudo kernelstub -a mem_sleep_default=deep
sudo kernelstub -a rcutree.rcu_idle_gp_delay=1
sudo kernelstub -p
kernelstub           : INFO     System information: 

    OS:..................Pop!_OS 20.04
    Root partition:....../dev/sda3
    Root FS UUID:........6ac882be-e46b-471a-b68f-2c8b8978a608
    ESP Path:............/boot/efi
    ESP Partition:......./dev/sda1
    ESP Partition #:.....1
    NVRAM entry #:.......-1
    Boot Variable #:.....0000
    Kernel Boot Options:.loglevel=0 splash systemd.show_status=false quiet mem_sleep_default=deep rcutree.rcu_idle_gp_delay=1
    Kernel Image Path:.../boot/vmlinuz-5.8.0-7630-generic
    Initrd Image Path:.../boot/initrd.img-5.8.0-7630-generic
    Force-overwrite:.....False

kernelstub           : INFO     Configuration details: 

   ESP Location:................../boot/efi
   Management Mode:...............True
   Install Loader configuration:..True
   Configuration version:.........3
   ```
 disabling sleep
 
 ```
 #can be a combination of these
 sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
 
 #enable the changes
 sudo systemctl restart systemd-logind.service
   
 #check status
 systemctl status sleep.target suspend.target hibernate.target hybrid-sleep.target
 
 #enable sleep
 systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target
 ```
