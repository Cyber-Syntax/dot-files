#!/usr/bin/env bash

COLORSCHEME=Dracula

### AUTOSTART PROGRAMS ###
run "eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)" & 
#run picom & # compositor
xset -dpms & # disable power management (DPMS) causes screen to sleep after 10 minutes
xset s off & # disable screen saver
picom & # compositor
#numlockx on &
#lxpolkit & # polkit agent
polkit &
#flameshot & # screenshot tool
gammastep & # redshift alternative (works wayland and xorg)
#nm-applet & # network manager applet
#keepassxc & # password manager
/home/developer/Documents/appimages/super-productivity.AppImage & # task manager app
/home/developer/Documents/repository/WallpaperChanger/main.py & # My wallpaper changer script

