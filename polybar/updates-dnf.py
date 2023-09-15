#!/usr/bin/python3
"""Check for updates using dnf"""
import subprocess

try:
    update = subprocess.check_output(["dnf", "updateinfo","-q", "--list"], stderr=subprocess.STDOUT)

    # count the number of updates
    update_count = int(update.decode("utf-8").count("\n"))

    if update_count > 0:
        print(str(update_count))
    elif update_count == 0:
        print("Up to date")

except subprocess.CalledProcessError:
    print("No Internet Connection")

# #!/bin/sh

# updates=$(dnf updateinfo -q --list | wc -l)

# if [ "$updates" -gt 0 ]; then
#     echo "Updates: $updates"
# elif [ "$updates" -eq 0 ]; then
#     echo "Up to date"
# elif
#     echo "No Internet Connection"
# fi
