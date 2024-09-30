#!/usr/bin/env bash

COLORSCHEME=Nord

xset -dpms & # disable power management (DPMS) causes screen to sleep after 10 minutes
xset s off & # disable screen saver
# ##Disable beep
# xset b off &

picom -b & # compositor
numlockx on &
nm-applet & # network manager applet
setxkbmap tr &
polkit &
gammastep & # redshift alternative (works wayland and xorg)
python3 /home/developer/Documents/repository/WallpaperChanger/main.py & 
keepassxc & # password manager
/home/developer/Documents/appimages/super-productivity.AppImage &

syncthing-tray & #TODO: Not starting, fix needed

#TESTING: handle inside python if this is not work
# get hostname, if it is desktop start xrandr else not
# sh /home/developer/Documents/screenloyout/asus_only.sh & # My screen layout script
if [ $(hostname) == "nixos" ]; then
  sh /home/developer/Documents/screenloyout/asus_only.sh & # My screen layout scripts
  printf "Desktop detected\n"
elif [ $(hostname) == "nixosLaptop" ]; then
  printf "Laptop detected\n"
fi

#nextcloud & # nextcloud client
#sh /home/developer/Documents/scripts/fedora-server/wake_fedora.sh & # Wake up Fedora Server everytime
#thunderbird & # email client
#birdtray & # birdtray for thunderbird
