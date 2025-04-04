#!/usr/bin/env bash
# COLORSCHEME=Nord
#FIX: not work for now on hyprland
# python3 /home/developer/Documents/repository/WallpaperChanger/main.py &
#FIX: gammastep not work on hyprland now.
# probably need wayland enabled on nixos while building
gammastep &
dunst &
nm-applet & # network manager applet
waybar &
syncthingtray &

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
