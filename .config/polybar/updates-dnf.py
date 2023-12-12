#!/usr/bin/python3
"""Check for updates using dnf"""
import subprocess

try:
    update = subprocess.check_output(["dnf", "updateinfo","-q", "--list"], stderr=subprocess.STDOUT)
    # find how much update available for flatpak
    update_flatpak = subprocess.check_output(["flatpak", "remote-ls", "--updates", "--user", "flathub"]).decode("utf-8")

    # split the output into lines
    lines = update_flatpak.split("\n")

    # count the number of lines
    update_count_flatpak = len(lines) - 1 # Subtract 1 because the last line is empty

    # print the number of updates
    if update_count_flatpak > 0:
        print(f"| Flatpak: {update_count_flatpak}", end=" | ")
    else:
        print(f"| Flatpak: Up to date", end=" | ")

    # count the number of updates
    update_count = int(update.decode("utf-8").count("\n"))

    if update_count > 0:
        print("DNF:", str(update_count) + " |")
    elif update_count == 0:
        print("DNF:", "Up to date |")

except subprocess.CalledProcessError:
    print("| No Internet Connection |")
