#!/bin/bash
# This script checks for available Fedora (dnf) and Flatpak updates,
# and prints a summary in the format:
# Fedora: <dnf count> | Flatpak: <flatpak count>
#
# For Fedora, it runs: dnf updateinfo -q list
# For Flatpak, it pipes an "n" into flatpak update so that it won’t install anything.

# ------------- DNF (Fedora) Update Info -------------
# Capture the output of dnf updateinfo
dnf_output=$(dnf updateinfo -q list 2>&1)

# If there are no updates, dnf usually outputs "Nothing to do."
if echo "$dnf_output" | grep -q "Nothing to do."; then
  fedora_count="None"
else
  # For a simple count, assume each update advisory starts with a word (e.g., "SECURITY" or "BUGFIX")
  # You might need to adjust the regex if your output format differs.
  fedora_count=$(echo "$dnf_output" | grep -E '^[[:space:]]*[A-Z]+' | wc -l | tr -d ' ')
fi

# ------------- Flatpak Update Info -------------
# Pipe a "n" into flatpak update to cancel installation.
flatpak_output=$(printf 'n\n' | flatpak update 2>&1)

# If flatpak outputs "Nothing to do.", then there are no updates.
if echo "$flatpak_output" | grep -q "Nothing to do."; then
  flatpak_count="None"
else
  # Filter update lines. In typical flatpak update output, update entries start with a number and a dot.
  flatpak_count=$(echo "$flatpak_output" | grep -E '^[[:space:]]*[0-9]+\.' | wc -l | tr -d ' ')
fi

# ------------- Combined Output -------------
echo "Fedora: $fedora_count | Flatpak: $flatpak_count"
