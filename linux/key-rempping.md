
Intro.

Key mappings can be changed using `xmodmap` in the Xorg layer. Sometimes, it did not work well and mappings should be changed whenever my keyboard was changed. I wanted to change the mapping in the lower level. `udev` gave me a solution.

Reference:
AtchLinux - Map scancodes to keycodes
1. Find your device

First, you need to find your keyboard device. I used my usb keyboard(HHKB).

With cat `/proc/bus/input/devices` command, you can confirm the information of your keyboard. In my case, the output was like below.

```
I: Bus=0003 Vendor=0853 Product=0100 Version=0111
N: Name="Topre Corporation HHKB Professional"
P: Phys=usb-0000:00:1d.0-1.8.3.1/input0
S: Sysfs=/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.8/2-1.8.3/2-1.8.3.1/2-1.8.3.1:1.0/0003:0853:0100.0002/input/input9
U: Uniq=
H: Handlers=sysrq kbd leds event7 
B: PROP=0
B: EV=120013
B: KEY=1000000000007 ff9f207ac14057ff febeffdfffefffff fffffffffffffffe
B: MSC=10
B: LED=1f
```

Bus, Vendor, Product and Handlers (event7) will be used in the following steps.
2. Find key information

Second, we need to grasp the scancode and the keycode of the key to be remapped. In my case, I wanted to map `RIGHTMETA` key to `HANJA` key (FYI, HANJA key is required in Korean keyboard).

`evtest` program was used to get the key information. If it is not installed in you system, install it with sudo apt install evtest (Ubuntu) or sudo dnf install evtest (Fedora).

Running evtest requires an event path as a parameter. The path is something like `/dev/input/eventX` where `X` is the Handler number that we could find in the Section 1. An example of my case follows.

    sudo evtest /dev/input/event7

After run `evtest` with proper path, your prompt will waiting your keyboard input. Just type the key that you are interested in. The prompt will show you the information of the key you typed.

```
...
Event: time 1512706221.107613, -------------- SYN_REPORT ------------
Event: time 1512708889.737079, type 4 (EV_MSC), code 4 (MSC_SCAN), value 700e7
Event: time 1512708889.737079, type 1 (EV_KEY), code 126 (KEY_RIGHTMETA), value 0
...
```

Remember the value (`700e7` in my case). It will be used in the next step.
3. Write configuration file

Now, you figured out all of your hardware information. It is time to write a configuration file.

The file could be in the one of these paths, `/usr/lib/udev/hwdb.d/`, `/run/udev/hwdb.d/`, and `/etc/udev/hwdb.d/`. I used `/etc/udev/hwdb.d`. FYI, the default mapping file which contains diverse keyboard mappings is `/usr/lib/udev/hwdb.d/60-keyboard.hwdb`.

Make a new file. The file name could be anything: `*.hwdb`

    sudo vim /etc/udev/hwdb.d/99-HHKB-keyboard.hwdb

Write the key mapping configuration. First you need to select a device. The format is like below.

    evdev:input:b<bus_id>v<vendor_id>p<product_id>e<version_id>-<modalias>

`<bus_id>`, `<vendor_id>`, and `<product_id>` are obtained in the Section 1.

If you want to change all the usb keyboard, use following configuration instead.

    keyboard:usb:v*p*

After the device selecting line, key mappings are described.

Format:

    KEYBOARD_KEY_<scan_code>=<key_code>

`<scan_code>` is the value we got with `evtest` and `<key_code>` is the lowercase name string of the key to be mapped. You can get the `<key_code>` information in the file `/usr/include/linux/input-event-codes.h` (variables are namded as `KEY_<key code>`).
evtest also shows the whole key mapping information as below.

```
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 1 (KEY_ESC)
    Event code 2 (KEY_1)
    Event code 3 (KEY_2)
    Event code 4 (KEY_3)
    Event code 5 (KEY_4)
    Event code 6 (KEY_5)
    Event code 7 (KEY_6)
    Event code 8 (KEY_7)
    Event code 9 (KEY_8)
    Event code 10 (KEY_9)
    Event code 11 (KEY_0)
    Event code 12 (KEY_MINUS)
    Event code 13 (KEY_EQUAL)
    Event code 14 (KEY_BACKSPACE)
...
```

Example: `<bus_id>=0003, <vendor_id>=0853, <product_id>=0100, <scan_code>=700e7, <key_code>=hanja`

    evdev:input:b0003v0853p0100*
     KEYBOARD_KEY_700e7=hanja
    
complete example:

```
evdev:input:*
keyboard:usb:v*p*
 KEYBOARD_KEY_70038=leftctrl # bind leftalt to leftctrl
 KEYBOARD_KEY_7001d=leftalt # bind leftctrl to leftalt
 KEYBOARD_KEY_700b8=rightctrl # bind righttalt to rightctrl
 KEYBOARD_KEY_7009d=rightalt # bind rightctrl to rightctrl
```

You can add more lines of key mappings continuously.
4. Apply your config

After saving the `.hwdb` file, you need to apply the configuration to your system.

1.Update `hwdb.bin` file with the written configuration file.

    sudo systemd-hwdb update

2.Reload `hwdb.bin` file to your system.

    sudo udevadm trigger

5. Confirm the key mapping

Just check the key works as you wanted, or

    udevadm info /dev/input/by-path/*-usb-*-kbd | grep KEYBOARD_KEY

or

    udevadm info /dev/input/eventX | grep KEYBOARD_KEY

will show the applied key mappings where `eventX` should be yours.

Done.
