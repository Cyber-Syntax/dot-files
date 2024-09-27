#!/bin/bash

# notification_content=$(echo "$@" | sed -n 's/.*summary: \(.*\)/\1/p')
#
# # Extract the application name from the notification
# app_name="$1"
#
# # Check if the application is the one we want to target
# if [ "$app_name" = "superproductivity" ]; then
#       qtile cmd-obj -o group 4 -f toscreen
# fi

# Get the notification content
notification_content=$(echo "$@" | sed -n 's/.*summary: \(.*\)/\1/p')

# Map the application name to a workspace or window
# This is a simplified example; adapt it to your needs
case "$notification_content" in
  "superproductivity")
        # Command to focus on the application in workspace 4
        qtile cmd-obj -o group 4 -f toscreen
        ;;
    # "App2")
    #     qtile cmd-obj -o window -f to_workspace -a 4
    #     ;;
    *)
        # Default action
        ;;
esac

