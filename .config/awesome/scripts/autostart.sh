#!/usr/bin/env sh
run_with_tz() { TZ=Europe/Istanbul "$@"; }
run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}
# run "xscreensaver" --no-splash &
run "nm-applet" 
# run "feh" --randomize --recursive --bg-fill ~/Pictures/Wallpapers/ &
run "picom" -b 
run "numlockx" on
run "setxkbmap" tr
run "gammastep" 
run "/home/developer/Documents/repository/WallpaperChanger/main.py" 
run "syncthingtray" 

#TESTING: handle inside python if this is not work
#Laptop statement is worked.
if [ $(hostname) == "nixos" ]; then
  #TODO: test later if screen cause issue.
  # run "xset" -dpms
  # run "xset" s off
  run_with_tz /home/developer/Documents/appimages/super-productivity.AppImage 
  run "/home/developer/Documents/scripts/screenloyout/asus_only.sh" 
  run "keepassxc" 
 elif [ $(hostname) == "nixosLaptop" ]; then
  run "cbatticon" -n  #TESTING: -n option?
fi

#nextcloud & # nextcloud client
#sh /home/developer/Documents/scripts/fedora-server/wake_fedora.sh & # Wake up Fedora Server everytime
#thunderbird & # email client
#birdtray & # birdtray for thunderbird
