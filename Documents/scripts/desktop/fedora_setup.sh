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
  fd-find   # modern find (fd <file_name>)
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
  luarocks
  cargo
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
#WARN: This maybe remove network manager and other important packages
#TODO: need to find a way to remove gnome without removing important packages
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
  playerctl
)

# List of Flatpak packages to install
flatpak_packages=(
  org.signal.Signal
  io.github.martchus.syncthingtray
  spotify
)

#ffmpeg-free to ffmpeg for fedora-to use h264 codec and others
function ffmpeg_swap() {
  echo "Swapping ffmpeg-free to ffmpeg..."
  dnf swap ffmpeg-free ffmpeg --allowerasing
  echo "ffmpeg-free swapped to ffmpeg."
}

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

# Function to handle RPM Fusion setup
enable_rpm_fusion() {
  echo "Enabling RPM Fusion"
  sudo dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf upgrade --refresh -y
  sudo dnf group upgrade -y core
  sudo dnf install -y rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted dnf-plugins-core
  echo "RPM Fusion Enabled"
}
# Function to speed up DNF
speed_up_dnf() {
  echo "Speeding Up DNF"
  echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
  echo 'pkg_gpgcheck=1' | sudo tee -a /etc/dnf/dnf.conf
  #TODO: manual setup is probably better for this because
  # this was using ping to find the fastest mirrors
  # but ping is not a good way to find the fastest mirrors
  # echo 'fastestmirror=true' | sudo tee -a /etc/dnf/dnf.conf
  echo "Your DNF config has now been amended"
}

# Function to install extras
#TODO: configure this function
# install_extras() {
#     echo "Installing Extras"
#     sudo dnf groupupdate -y sound-and-video
#     sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
#     sudo dnf install -y libdvdcss
#     sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
#     sudo dnf install -y lame\* --exclude=lame-devel
#     sudo dnf group upgrade -y --with-optional Multimedia
#     sudo dnf config-manager --set-enabled fedora-cisco-openh264
#     sudo dnf install -y gstreamer1-plugin-openh264 mozilla-openh264
#     sudo dnf copr enable peterwu/iosevka -y
#     sudo dnf update -y
#     sudo dnf install -y iosevka-term-fonts jetbrains-mono-fonts-all terminus-fonts terminus-fonts-console google-noto-fonts-common fira-code-fonts cabextract xorg-x11-font-utils fontconfig
#     sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
#     notify "All done"
# }

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
# cp ~/Documents/app_backups/desktop/fstab /etc/fstab
# cp ~/Documents/app_backups/desktop/boot /etc/default/boot
# cp ~/Documents/app_backups/desktop/dnf.conf /etc/dnf/dnf.conf
# sudo cp ~/Documents/app_backups/desktop/custom.conf /etc/gdm/custom.conf
# cp ~/Documents/app_backups/desktop/99-tcp-bbr.conf /etc/sysctl.d/99-tcp-bbr.conf
function setup_files() {
  echo "Copying files: fstab, boot, dnf.conf, custom.conf(gdm autologin), 99-tcp-bbr.conf..."
  cp /home/developer/Documents/scripts/desktop/fstab /etc/fstab
  cp /home/developer/Documents/scripts/desktop/boot /etc/default/boot
  cp /home/developer/Documents/scripts/desktop/dnf.conf /etc/dnf/dnf.conf
  cp /home/developer/Documents/scripts/desktop/custom.conf /etc/gdm/custom.conf
  cp /home/developer/Documents/scripts/desktop/99-tcp-bbr.conf /etc/sysctl.d/99-tcp-bbr.conf
  echo "Files copied."
}

# borgbackup and trash-cli services
function service_setup() {
  echo "Copying service files..."
  cp /home/developer/Documents/scripts/desktop/borg/borgbackup-home.timer /etc/systemd/system/borgbackup-home.timer
  cp /home/developer/Documents/scripts/desktop/borg/borgbackup-home.service /etc/systemd/system/borgbackup-home.service
  cp /home/developer/Documents/scripts/general/trash-cli.service /etc/systemd/system/trash-cli.service
  cp /home/developer/Documents/scripts/general/trash-cli.timer /etc/systemd/system/trash-cli.timer
  echo "Enabling and starting services..."
  systemctl enable --now borgbackup-home.timer
  systemctl enable --now trash-cli.timer
  echo "Services setup completed."
}

# Disable nvidia-powerd service because it is used for optimus nvidia cards
# sudo systemctl disable nvidia-powerd.service
function disable_nvidia_powerd() {
  echo "Disabling nvidia-powerd service..."
  systemctl disable nvidia-powerd.service
  echo "nvidia-powerd service disabled."
}

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
# install_packages
# install_brave
# install_librewolf
# install_flatpak_packages
# remove_gnome
# remove_gnome_packages
# install_qtile_packages
# enable_rpm_fusion
speed_up_dnf
echo "Installation completed."

#Install protonvpn to fedora
# optional indicator for protonvpn-app on gnome only
# # sudo dnf install libappindicator-gtk3 gnome-shell-extension-appindicator gnome-extensions-app
#TODO: need to find a way to get the latest version
# 1. Download the package. Enter:
#
# wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.2-1.noarch.rpm"
# 2. Install the Proton VPN repository containing the new app. Run:
#
# sudo dnf install ./protonvpn-stable-release-1.0.2-1.noarch.rpm && sudo dnf check-update --refresh
# 3. Run:
#
# sudo dnf install proton-vpn-gnome-desktop
#

#enable openvpn for selinux
# sudo semodule -i myopenvpn.pp

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
