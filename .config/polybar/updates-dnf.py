#!/usr/bin/python3
"""Check for updates using dnf"""
import subprocess

def dnf_update():
    """Check for updates using dnf"""
    # find how much update available for dnf
    update = subprocess.check_output(["dnf", "updateinfo","-q", "--list"], stderr=subprocess.STDOUT)

    # count
    update_count = int(update.decode("utf-8").count("\n"))

    return update_count

def flatpak_update():
    """Check for updates using flatpak"""
    # find how much update available for flatpak
    update_flatpak = subprocess.check_output(["flatpak", "remote-ls",
                                                "--updates", "--user", "flathub"]).decode("utf-8")
    # split the output into lines
    lines = update_flatpak.split("\n")

    # count the number of lines
    update_count_flatpak = len(lines) - 1 # Subtract 1 because the last line is empty

    return update_count_flatpak

def print_update(update_count, update_count_flatpak):
    """Print the update count"""
    # Check if both are up to date
    if update_count == 0 and update_count_flatpak == 0:
        print("System is up to date")

    # dnf
    if update_count > 0:
        print(f"Updates available: {update_count}")
    else:
        print("DNF: Up to date")

    # flatpak
    if update_count_flatpak > 0:
        print(f"Flatpak Updates available: {update_count_flatpak}")
    else:
        print("Flatpak: Up to date")

def main():
    try:
        # find how much update available for dnf
        dnf_count = dnf_update()

        # find how much update available for flatpak
        flatpak_count = flatpak_update()

        # print the update count
        print_update(dnf_count, flatpak_count)
    except subprocess.CalledProcessError:
        print("Error: dnf or flatpak not installed")
    except Exception as exception:
        print("Error:", exception)

if __name__ == "__main__":
    main()
