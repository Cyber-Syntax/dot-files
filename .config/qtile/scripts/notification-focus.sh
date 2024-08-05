#!/bin/bash

# Extract the application name from the notification
app_name="$1"

# Check if the application is the one we want to target
if [ "$app_name" = "superproductivity" ]; then
    # Use xdotool to find the window associated with the application and focus on it
    window_id=$(xdotool search --class "superproductivity" | head -1)
    xdotool windowactivate "$window_id"
fi
