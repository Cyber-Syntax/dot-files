#!/bin/sh
set -x # Enable verbose output for debugging

export DISPLAY=":0"

#monitor_center="DP-2"
monitor_center="HDMI-0"
#rate=143.97
rate=120

# Check if "None-1-1" is a connected output
if xrandr | grep -q "None-1-1 connected"; then
  xrandr --output None-1-1 --off
else
  echo "None-1-1 is not connected. Skipping..."
fi

# Define the display configurations
xrandr --output $monitor_center --primary --rate $rate --mode 2560x1440 --rotate normal
