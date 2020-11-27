getting sleep to work

from https://github.com/pop-os/pop/issues/349

https://fueledonbacon.com/popos-20-04-fix-wake-from-suspend-and-with-keyboard/

    sudo kernelstub -o "loglevel=0 splash systemd.show_status=false quiet mem_sleep_default=deep"
