#!/bin/bash
# This script checks for available Fedora (dnf) and Flatpak updates,
# and prints a summary in the format:
# Fedora: <dnf count> | Flatpak: <flatpak count>

# Set a timeout for commands to prevent hanging
timeout_cmd="timeout 10"

# ------------- DNF (Fedora) Update Info -------------
# Use dnf check-update which is the proper way to check for available updates
# Exit code 100 means updates are available, 0 means no updates
dnf_output=$($timeout_cmd dnf check-update 2>/dev/null)
dnf_exit=$?

if [ $dnf_exit -eq 0 ]; then
    # No updates available
    fedora_count="0"
elif [ $dnf_exit -eq 100 ]; then
    # Updates available - count non-empty lines after the header
    fedora_count=$(echo "$dnf_output" | sed '1,/^$/d' | grep -v '^$' | wc -l | tr -d ' ')
else
    # Any other exit code indicates an error
    fedora_count="?"
fi

# ------------- Flatpak Update Info -------------
# Use flatpak update --no-deploy to show available updates without installing
flatpak_output=$($timeout_cmd flatpak update --no-deploy 2>/dev/null || echo "Error")

if [ "$flatpak_output" = "Error" ]; then
    flatpak_count="?"
elif echo "$flatpak_output" | grep -q "Nothing to do."; then
    flatpak_count="0"
else
    # Count lines that start with a number and dot pattern (actual updates)
    flatpak_count=$(echo "$flatpak_output" | grep -E '^[[:space:]]*[0-9]+\.' | wc -l | tr -d ' ')
    if [ "$flatpak_count" = "0" ] && ! echo "$flatpak_output" | grep -q "Nothing to do."; then
        flatpak_count="?"
    fi
fi

# ------------- Combined Output -------------
# Show "None" instead of "0" for better readability
[ "$fedora_count" = "0" ] && fedora_count="✅"
[ "$flatpak_count" = "0" ] && flatpak_count="✅"

FEDORA_ICON=$'\uf30a'  # FontAwesome Fedora logo

echo "$FEDORA_ICON : $fedora_count | 📦: $flatpak_count"
