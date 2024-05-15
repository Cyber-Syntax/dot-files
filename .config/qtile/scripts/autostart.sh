#!/usr/bin/env bash

COLORSCHEME=Nord

### AUTOSTART PROGRAMS ###
##Not work on nixos
#run "eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)" & 
xset -dpms & # disable power management (DPMS) causes screen to sleep after 10 minutes
xset s off & # disable screen saver
# ### setup screensaver
# ##Disable beep
# xset b off &

picom & # compositor
#numlockx on &
#lxpolkit & # polkit agent
setxkbmap tr &
polkit &
gammastep & # redshift alternative (works wayland and xorg)
/home/developer/Documents/appimages/super-productivity.AppImage & # task manager app
python3 /home/developer/Documents/repository/WallpaperChanger/main.py & # My wallpaper changer script
/home/developer/Documents/screenloyout/xrandr.sh & # My screen layout script
keepassxc & # password manager
/home/developer/Documents/appimages/siyuan.AppImage & # note taking app
