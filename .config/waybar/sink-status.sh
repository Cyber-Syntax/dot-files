#!/bin/bash
# Print current active sink name

# Get active sink name pipewire-pulse
name=$(pactl list sinks short | grep "RUNNING" | cut -f 2)

# Replace sink name with custom name
if [ "$name" = "alsa_output.pci-0000_28_00.3.analog-surround-51" ]; then
    echo "Headset"
elif [ "$name" = "alsa_output.pci-0000_26_00.1.hdmi-stereo-extra1" ]; then
    echo "DP-1"
elif [ "$name" = "alsa_output.pci-0000_26_00.1.hdmi-stereo-extra2" ]; then
    echo "DP-2"
else:
    echo "Sink"
fi