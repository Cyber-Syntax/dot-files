#!/usr/bin/env bash
# COLORSCHEME=Nord
# python3 /home/developer/Documents/repository/WallpaperChanger/main.py &
gammastep &
dunst &
nm-applet & # network manager applet
waybar &
syncthingtray &
# gammastep & # redshift alternative (works wayland and xorg)

#TESTING: handle inside python if this is not work
#Laptop statement is worked.
if [ $(hostname) == "nixos" ]; then
  TZ=Europe/Istanbul /home/developer/Documents/appimages/super-productivity.AppImage & # task app
  keepassxc & # password manager
  #ckb-next-daemon
 elif [ $(hostname) == "nixosLaptop" ]; then
  cbatticon & # battery notification, systray app
  blueman-applet
fi

#nextcloud & # nextcloud client
#sh /home/developer/Documents/scripts/fedora-server/wake_fedora.sh & # Wake up Fedora Server everytime
#thunderbird & # email client
#birdtray & # birdtray for thunderbird
