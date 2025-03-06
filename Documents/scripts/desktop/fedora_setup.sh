#!/bin/bash
# This script installs common packages using dnf.
# It is intended for distributions that use the dnf package manager (e.g., Fedora, RHEL, CentOS Stream).

# List of packages to install
PACKAGES=(
  zsh
  vim
  feh # wallpaper
  #TODO: learn firewalld or use ufw
  ufw # fedora use firewalld default
  #productivity
  zoxide    # modern cd
  eza       # modern ls
  trash-cli # trash-put tp command
  zsh-autosuggestions
  zsh-syntax-highlighting
  #diagnostic
  lm_sensors
  htop
  btop
  xev
  # programming languages
  pip
  # ffmpeg # defualt fmmpeg-free installed already
  # ffmpeg-libs # no match
  #password manager
  keepassxc
  seahorse # gnome keyring
  # text editor
  neovim
  vim
  bash-language-server
  # virtualization
  virt-manager
  libvirt
  # sync
  syncthing
  # backup
  borgbackup
  # nvidia
  nvidia-open
)
gnome_packages=(
  gnome-tweaks
  gnome-extensions-app # Extensions app
)
fedora_gnome_default_installed_packages=(

)
# completely remove gnome desktop environment
remove_gnome=(
  gnome-shell
  gnome-session-xsessions
  gnome-session
)

qtile_packages=(
  feh
  picom
  rofi
  qtile-extras
  lxappearance
  gdm # is in use for now
  # lightdm #FIX: or switch some other display manager
  gammastep
  numlockx
  dunst
  flameshot
)

# List of Flatpak packages to install
flatpak_packages=(
  org.signal.Signal
  io.github.martchus.syncthingtray
)

# Function to install gnome qtile_packages
install_gnome_packages() {
  echo "Installing Gnome packages..."
  for pkg in "${gnome_packages[@]}"; do
    echo "Installing $pkg ..."
    dnf install -y "$pkg"
  done
}

# Function to install qtile qtile_packages
install_qtile_packages() {
  echo "Installing Qtile packages..."
  for pkg in "${qtile_packages[@]}"; do
    echo "Installing $pkg ..."
    dnf install -y "$pkg"
  done
}

install_flatpak_packages() {
  echo "Installing Flatpak packages..."
  for pkg in "${flatpak_packages[@]}"; do
    echo "Installing $pkg ..."
    flatpak install -y flathub "$pkg"
  done
}

# Function to install Flatpak flatpak_packages
install_flatpak_packages() {
  echo "Installing Flatpak packages..."
  for pkg in "${flatpak_packages[@]}"; do
    echo "Installing $pkg ..."
    flatpak install -y flathub "$pkg"
  done
}

# Function to check if the script is run as root
check_root() {
  if [[ $EUID -ne 0 ]]; then
    echo "This script requires root privileges. Run with sudo or as root."
    exit 1
  fi
}

# Update repository and install packages function
install_packages() {
  echo "Updating repositories..."
  dnf update -y

  echo "Installing packages..."
  for pkg in "${PACKAGES[@]}"; do
    echo "Installing $pkg ..."
    dnf install -y "$pkg"
  done
}

# Add and install Brave Browser
install_brave() {
  echo "Installing Brave Browser..."

  # Install dnf-plugins-core if not already installed
  dnf install -y dnf-plugins-core

  # Add Brave Browser repo
  echo "Adding Brave Browser repository..."
  dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

  # Install Brave Browser package
  dnf install -y brave-browser
}

# Add and install Librewolf
install_librewolf() {
  echo "Installing Librewolf..."

  # Add the Librewolf repository using curl and pkexec to place the repo file in /etc/yum.repos.d/
  curl -fsSL https://repo.librewolf.net/librewolf.repo | pkexec tee /etc/yum.repos.d/librewolf.repo >/dev/null

  # Install Librewolf package
  dnf install -y librewolf
}

#TODO: setup this if needed
# echo "Enabling RPM Fusion repositories..."
# # Enable RPM Fusion Free repository
# sudo dnf install -y "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" &&
#   echo "RPM Fusion Free repository enabled."
#
# # Enable RPM Fusion Nonfree repository
# sudo dnf install -y "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" &&
#   echo "RPM Fusion Nonfree repository enabled."# Main execution flow
#
#TODO: add scaling for hidpi if needed
# gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer', 'xwayland-native-scaling']"

#Switch xorg if wayland cause problem
#TODO: make this function
# Open /etc/gdm/custom.conf and uncomment WaylandEnable=false.
#install xorg packages when switching to gnome-xorg
# gnome-session-xsession
# @base-x # exclude nouveau and amdgpu

#
# Add the following line to the [daemon] section:
#
# DefaultSession=gnome-xorg.desktop

#TODO: find a way to update those files more easily
# maybe linking them ?
# boot settings
# cp ~/Documents/app_backups/desktop/fstab /etc/fstab
# boot
# cp ~/Documents/app_backups/desktop/boot /etc/default/boot
# dnf.conf
# cp ~/Documents/app_backups/desktop/dnf.conf /etc/dnf/dnf.conf
# autologin
# sudo cp ~/Documents/app_backups/desktop/custom.conf /etc/gdm/custom.conf
# tcp_bbr
# cp ~/Documents/app_backups/desktop/99-tcp-bbr.conf /etc/sysctl.d/99-tcp-bbr.conf

# Delete packages when switching qtile
delete_gnome_packages() {
  echo "Deleting Gnome packages..."
  for pkg in "${gnome_packages[@]}"; do
    echo "Deleting $pkg ..."
    dnf remove -y "$pkg"
  done
}
echo "Installing packages..."

check_root
install_packages
install_brave
install_librewolf
install_flatpak_packages
# remove_gnome
# remove_gnome_packages
install_qtile_packages
echo "Installation completed."

# # switch_display_manager
#TODO: need proper error handling
# also need to make user to start this on tty instead of any de or wm
# switch_display_manager() {
#   echo "Switching display manager to LightDM..."
#   systemctl enable lightdm
#   systemctl disable gdm
#   systemctl stop gdm
#   systemctl start lightdm
#   echo "Display manager switched to LightDM."
# }
