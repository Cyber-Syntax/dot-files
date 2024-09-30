#!/usr/bin/env bash

COLORSCHEME=Nord

picom -b & # compositor
numlockx on &
nm-applet & # network manager applet
setxkbmap tr &
polkit &
gammastep & # redshift alternative (works wayland and xorg)
python3 /home/developer/Documents/repository/WallpaperChanger/main.py & 
keepassxc & # password manager
/home/developer/Documents/appimages/super-productivity.AppImage &

sync-trayzor & #TODO: Not starting, fix needed
