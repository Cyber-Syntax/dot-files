#!/usr/bin/python3
"""Check for updates using dnf"""
import subprocess

def dnf_update():
    """Check for updates using dnf"""
    # find how much update available for dnf
    update = subprocess.check_output(["dnf", "updateinfo","-q", "--list"], stderr=subprocess.STDOUT)

    # count
    update_count_dnf = int(update.decode("utf-8").count("\n"))

    return update_count_dnf

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

def print_update_flatpak(update_count_flatpak):
    """Print the update count for flatpak"""
    if update_count_flatpak > 0:
        print(f"Flatpak: {update_count_flatpak}")
    else:
        print("Flatpak: Up to date")


def print_update(update_count_dnf, update_count_flatpak):
    """Print the update count"""
    # Check if both are up to date
    if update_count_dnf == 0 and update_count_flatpak == 0:
        print("Up to Date ")
        # return: exit the function, so rest of the code won't execute
        return

    # dnf check
    if update_count_dnf > 0:
        print(f" {update_count_dnf}")

    # flatpak check
    if update_count_flatpak > 0:
        print(f"Flatpak: {update_count_flatpak}")


def main():
    """Main function"""
    try:
        # find how much update available for dnf
        dnf_count = dnf_update()

        # find how much update available for flatpak
        flatpak_count = flatpak_update()

        # print the update count
        print_update(dnf_count, flatpak_count)
    except subprocess.CalledProcessError:
        print("Error: DNF or Flatpak is not installed.")
    except Exception as exception:
        print("Error:", exception)

if __name__ == "__main__":
    main()
