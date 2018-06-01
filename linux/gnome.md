### setting up xmodmap to swap alt/ctrl

create a `~/.Xmodmap` file with:

```
clear control
clear mod1
keycode 37 = Alt_L Meta_L
keycode 105 = Alt_R Meta_R
keycode 64 = Control_L
keycode 108 = Control_R
add control = Control_L Control_R
add mod1 = Alt_L Meta_L
```

create a startup item `.config/autostart/xmodmap.desktop` with the following content:

```
[Desktop Entry]
Name[en_US]=Xmodmap
Comment[en_US]=xmodmap ~/.Xmodmap
Exec=/usr/bin/xmodmap .Xmodmap
Icon=application-default-icon
X-GNOME-Autostart-enabled=true
Type=Application
```

