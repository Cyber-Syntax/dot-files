#!/bin/bash
set -x #echo on
if [[ $DISPLAY == ":0" ]]; then
        export DISPLAY=:0
else
    	export DISPLAY=:1
fi

xrandr  \
       	--output DP-2 --primary --rate 143.97 --mode 2560x1440 --rotate normal \
       	--output HDMI-0 --rate 59.79 --mode 1366x768 --rotate normal --right-of DP-2 \
       	--output DP-0 --mode 1920x1080 --pos 0x0 --rate 144 --rotate normal --left-of DP-2 \
       	--output DP-3 --off --output DP-4 --off --output DP-5 --off --output None-1-1 --off
