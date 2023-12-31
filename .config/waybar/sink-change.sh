# #!/bin/bash

# Get active sink name
name=$(pactl list sinks short | grep "RUNNING" | cut -f 2)

# Define sink names
headset='alsa_output.pci-0000_28_00.3.analog-surround-51'
DP_1='alsa_output.pci-0000_26_00.1.hdmi-stereo-extra1'
DP_2='alsa_output.pci-0000_26_00.1.hdmi-stereo-extra2'

# Get available sink names
names=$(pactl list sinks short | cut -f 2)

# Change sink to next available sink, if current sink is not available
if [ $name = $headset ]; then
    if [[ $names == *$DP_1* ]]; then
        pactl set-default-sink $DP_1
    elif [[ $names == *$DP_2* ]]; then
        pactl set-default-sink $DP_2
    else
        echo "No available sinks"
    fi
elif [ $name = $DP_1 ]; then
    if [[ $names == *$DP_2* ]]; then
        pactl set-default-sink $DP_2
    elif [[ $names == *$headset* ]]; then
        pactl set-default-sink $headset
    else
        echo "No available sinks"
    fi
elif [ $name = $DP_2 ]; then
    if [[ $names == *$headset* ]]; then
        pactl set-default-sink $headset
    elif [[ $names == *$DP_1* ]]; then
        pactl set-default-sink $DP_1
    else
        echo "No available sinks"
    fi
else
    echo "Unknown"
fi




