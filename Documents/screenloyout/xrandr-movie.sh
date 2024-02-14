#!/bin/bash
set -x # Enable verbose output for debugging

# Function to get the current DISPLAY value
get_active_display() {
    local display_env
    # Try to get the DISPLAY from the gnome-terminal-server process if available
    display_env=$(cat /proc/$(pidof "gnome-terminal-server")/environ  2>/dev/null | tr '\0' '\n' | grep ^DISPLAY=)

    # If the above fails, try to get the DISPLAY from the current user's processes
    if [ -z "$display_env" ]; then
        display_env=$(ps -o pid,comm= -u $USER | while read -r pid comm; do
            if [ "$comm" = "Xorg" ]; then
                cat /proc/$pid/environ  2>/dev/null | tr '\0' '\n' | grep ^DISPLAY=
            fi
        done)
    fi

    # Extract the actual DISPLAY value from the environment variable
    display_value=$(echo "$display_env" | cut -d= -f2)
    echo "$display_value"
}

# Set the DISPLAY variable based on the result of the function
export DISPLAY=$(get_active_display)

monitor_left="DP-0"
monitor_center="DP-2"
monitor_right="HDMI-0"

# Check if "None-1-1" is a connected output
if xrandr | grep -q "None-1-1 connected"; then
	xrandr --output None-1-1 --off
else
	echo "None-1-1 is not connected. Skipping..."
fi
  
# Define the display configurations
xrandr --output $monitor_center --primary --rate 143.97 --mode 2560x1440 --rotate normal \
       --output $monitor_right --rate 59.79 --mode 1366x768 --rotate normal --right-of $monitor_center \
       --output $monitor_left --off \
       --output DP-3 --off \
       --output DP-4 --off \
       --output DP-5 --off \
