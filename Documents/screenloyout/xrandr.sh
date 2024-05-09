       #--output $monitor_right --rate 59.79 --mode 1366x768 --rotate normal --right-of $monitor_center \
#!/bin/sh
set -x # Enable verbose output for debugging

# systemctl --user import-environment DISPLAY XAUTHORITY
#
# if command -v dbus-update-activation-environment >/dev/null 2>&1; then
#     dbus-update-activation-environment DISPLAY XAUTHORITY
# fi
#
# Check if the current DISPLAY is ":0" or not
if [[ $DISPLAY == ":0" ]]; then
    export DISPLAY=:0
else
    export DISPLAY=:1
fi

monitor_left="DP-0"
monitor_center="DP-2"
#monitor_right="HDMI-0" # no longer in use
#--output $monitor_right --rate 59.79 --mode 1366x768 --rotate normal --right-of $monitor_center \

# Define the display configurations
xrandr --output $monitor_center --primary --rate 143.97 --mode 2560x1440 --rotate normal \
       --output $monitor_left --mode 1920x1080 --pos 0x0 --rate 75 --rotate normal --left-of $monitor_center \
       --output HDMI-0 --off \
       --output DP-3 --off \
       --output DP-4 --off \
       --output DP-5 --off \
