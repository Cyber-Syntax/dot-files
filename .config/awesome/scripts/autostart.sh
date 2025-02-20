#!/usr/bin/env bash

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run picom -b  # compositor
run numlockx on 
run nm-applet  # network manager applet
run setxkbmap tr 
run gammastep # redshift alternative (works wayland and xorg)
run python3 /home/developer/Documents/repository/WallpaperChanger/main.py &
run syncthingtray 

#TESTING: handle inside python if this is not work
#Laptop statement is worked.
if [ $(hostname) == "nixos" ]; then
  run xset -dpms  # disable power management (DPMS) causes screen to sleep after 10 minutes
  run xset s off  # disable screen saver
  run TZ=Europe/Istanbul /home/developer/Documents/appimages/super-productivity.AppImage # task app
  run sh /home/developer/Documents/scripts/screenloyout/asus_only.sh  # My screen layout scripts
  run keepassxc  # password manager
 elif [ $(hostname) == "nixosLaptop" ]; then
  run cbatticon  # battery notification, systray app
fi

#nextcloud & # nextcloud client
#sh /home/developer/Documents/scripts/fedora-server/wake_fedora.sh & # Wake up Fedora Server everytime
#thunderbird & # email client
#birdtray & # birdtray for thunderbird
