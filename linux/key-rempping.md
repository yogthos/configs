
Intro.

Key mappings can be changed using `xmodmap` in the Xorg layer. Sometimes, it did not work well and mappings should be changed whenever my keyboard was changed. I wanted to change the mapping in the lower level. `udev` gave me a solution.

Reference:
AtchLinux - Map scancodes to keycodes
1. Find your device

First, you need to find your keyboard device. I used my usb keyboard(HHKB).

With cat `/proc/bus/input/devices` command, you can confirm the information of your keyboard. In my case, the output was like below.

```
I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/devices/platform/i8042/serio0/input/input0
U: Uniq=
H: Handlers=sysrq kbd event0 leds 
B: PROP=0
B: EV=120013
B: KEY=1100f02902000 8380307cf910f001 feffffdfffefffff fffffffffffffffe
B: MSC=10
B: LED=7
```

Bus, Vendor, Product and Handlers (event0) will be used in the following steps.
2. Find key information

Second, we need to grasp the scancode and the keycode of the key to be remapped. In my case, I wanted to swap `alt` and `ctrl` keys.

The `evtest` program was used to get the key information.

Running evtest requires an event path as a parameter. The path is something like `/dev/input/eventX` where `X` is the Handler number that we could find in the Section 1. An example of my case follows.

    sudo evtest /dev/input/event0

After run `evtest` with proper path, your prompt will waiting your keyboard input. Just type the key that you are interested in. The prompt will show you the information of the key you typed.

```
Event: time 1528092620.744242, type 4 (EV_MSC), code 4 (MSC_SCAN), value 1d
Event: time 1528092620.744242, type 1 (EV_KEY), code 29 (KEY_LEFTCTRL), value 1
Event: time 1528092674.425227, type 4 (EV_MSC), code 4 (MSC_SCAN), value 38
Event: time 1528092674.425227, type 1 (EV_KEY), code 56 (KEY_LEFTALT), value 1

Event: time 1528092695.607297, type 4 (EV_MSC), code 4 (MSC_SCAN), value 9d
Event: time 1528092695.607297, type 1 (EV_KEY), code 97 (KEY_RIGHTCTRL), value 1
Event: time 1528092712.270573, type 4 (EV_MSC), code 4 (MSC_SCAN), value b8
Event: time 1528092712.270573, type 1 (EV_KEY), code 100 (KEY_RIGHTALT), value 
...
```

Remember the values (`1d`, `38`, `9d`, and `b8` in my case). It will be used in the next step.
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

The key mappings are described after the device selecting line, and must be indented!

Format:

    keyboard:usb:<device_id>  
     KEYBOARD_KEY_<scan_code>=<key_code>
  
complete example:

```
evdev:input:*
keyboard:usb:v*p*
 KEYBOARD_KEY_38=leftctrl # bind leftalt to leftctrl
 KEYBOARD_KEY_1d=leftalt # bind leftctrl to leftalt
 KEYBOARD_KEY_b8=rightctrl # bind righttalt to rightctrl
 KEYBOARD_KEY_9d=rightalt # bind rightctrl to rightctr
```

You can add more lines of key mappings continuously.

4. Apply your config

After saving the `.hwdb` file, you need to apply the configuration to your system.

1. Update `hwdb.bin` file with the written configuration file.

    sudo systemd-hwdb update

2. Reload `hwdb.bin` file to your system.

    sudo udevadm trigger

5. Confirm the key mapping

Just check the key works as you wanted, or

    udevadm info /dev/input/by-path/*-usb-*-kbd | grep KEYBOARD_KEY

or

    udevadm info /dev/input/eventX | grep KEYBOARD_KEY

will show the applied key mappings where `eventX` should be yours.

Done.
