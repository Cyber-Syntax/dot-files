#!/usr/bin/env bash

COLORSCHEME=Mocha

### AUTOSTART PROGRAMS ###
##Not work on nixos
#run "eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)" & 
xset -dpms & # disable power management (DPMS) causes screen to sleep after 10 minutes
xset s off & # disable screen saver
# ### setup screensaver
# ##Disable beep
# xset b off &

picom -b & # compositor
numlockx on &
nm-applet & # network manager applet
#lxpolkit & # polkit agent
setxkbmap tr &
polkit &
gammastep & # redshift alternative (works wayland and xorg)
/home/developer/Documents/appimages/super-productivity.AppImage &
python3 /home/developer/Documents/repository/WallpaperChanger/main.py & 
sh /home/developer/Documents/screenloyout/xrandr.sh & # My screen layout script
keepassxc & # password manager
syncthing-tray & # syncthing tray app
nextcloud & # nextcloud client
