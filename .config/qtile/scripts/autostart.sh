#!/usr/bin/env bash
COLORSCHEME=Nord

picom -b & # compositor
numlockx on &
nm-applet & # network manager applet
setxkbmap tr &
#polkit & # not work probably need to define on nix or need to install package
gammastep & # redshift alternative (works wayland and xorg)
python3 /home/developer/Documents/repository/WallpaperChanger/main.py &
syncthingtray &

#TESTING: handle inside python if this is not work
#Laptop statement is worked.
if [ $(hostname) == "nixos" ]; then
  xset -dpms & # disable power management (DPMS) causes screen to sleep after 10 minutes
  xset s off & # disable screen saver
  TZ=Europe/Istanbul /home/developer/Documents/appimages/super-productivity.AppImage & # task app
  sh /home/developer/Documents/scripts/screenloyout/asus_only.sh & # My screen layout scripts
  keepassxc & # password manager
 elif [ $(hostname) == "nixosLaptop" ]; then
  cbatticon & # battery notification, systray app
fi

#nextcloud & # nextcloud client
#sh /home/developer/Documents/scripts/fedora-server/wake_fedora.sh & # Wake up Fedora Server everytime
#thunderbird & # email client
#birdtray & # birdtray for thunderbird
