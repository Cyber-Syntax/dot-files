#!/usr/bin/env bash

COLORSCHEME=Mocha

### AUTOSTART PROGRAMS ###
#run "eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)" & # nixos already start this
xset -dpms & # disable power management (DPMS) causes screen to sleep after 10 minutes
xset s off & # disable screen saver
# ### setup screensaver
# ##Disable beep
# xset b off &

picom -b & # compositor
numlockx on &
nm-applet & # network manager applet
setxkbmap tr &
polkit &
gammastep & # redshift alternative (works wayland and xorg)
python3 /home/developer/Documents/repository/WallpaperChanger/main.py & 
sh /home/developer/Documents/screenloyout/asus_only.sh & # My screen layout script
keepassxc & # password manager
/home/developer/Documents/appimages/super-productivity.AppImage &


syncthing-tray & #TODO: Not starting, fix needed

#nextcloud & # nextcloud client
#sh /home/developer/Documents/scripts/fedora-server/wake_fedora.sh & # Wake up Fedora Server everytime
#thunderbird & # email client
#birdtray & # birdtray for thunderbird
