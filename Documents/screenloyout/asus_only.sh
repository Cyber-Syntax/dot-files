#!/bin/sh
set -x # Enable verbose output for debugging

export DISPLAY=":0"

monitor_center="DP-2"

# Check if "None-1-1" is a connected output
if xrandr | grep -q "None-1-1 connected"; then
	xrandr --output None-1-1 --off
else
	echo "None-1-1 is not connected. Skipping..."
fi

# Define the display configurations
xrandr --output $monitor_center --primary --rate 143.97 --mode 2560x1440 --rotate normal 
