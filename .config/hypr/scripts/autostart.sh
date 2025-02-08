#!/usr/bin/env bash
# COLORSCHEME=Nord
# python3 /home/developer/Documents/repository/WallpaperChanger/main.py &
dunst &
nm-applet & # network manager applet
gammastep & # redshift alternative (works wayland and xorg)
syncthingtray &

#TESTING: handle inside python if this is not work
#Laptop statement is worked.
if [ $(hostname) == "nixos" ]; then
  TZ=Europe/Istanbul /home/developer/Documents/appimages/super-productivity.AppImage & # task app
  keepassxc & # password manager
 elif [ $(hostname) == "nixosLaptop" ]; then
  cbatticon & # battery notification, systray app
  blueman-applet
fi

#nextcloud & # nextcloud client
#sh /home/developer/Documents/scripts/fedora-server/wake_fedora.sh & # Wake up Fedora Server everytime
#thunderbird & # email client
#birdtray & # birdtray for thunderbird
