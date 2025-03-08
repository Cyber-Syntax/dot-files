#!/bin/bash
# Comprehensive installation and configuration script for dnf-based systems.
#
# Additional functions can be run via command‑line options.
#
# Options:
#   -a    Do everything (run all additional functions).
#   -F    Install Flatpak packages.
#   -l    Install Librewolf browser.
#   -q    Install Qtile packages.
#   -b    Install Brave Browser.
#   -r    Enable RPM Fusion repositories.
#   -s    Setup system services (borgbackup, trash-cli).
#   -d    Speed up DNF (update /etc/dnf/dnf.conf with pkg_gpgcheck and max_parallel_downloads).
#   -x    Swap ffmpeg-free with ffmpeg.
#   -f    Overwrite configuration files (boot, GDM, sysctl, sudoers).
#   -h    Display this help message.
#
# Example (run as root):
#   sudo ./script.sh -a
#
#---------------------------------------------------------------------
# Bash strict mode settings.
#---------------------------------------------------------------------
set -euo pipefail
IFS=$'\n\t'

#---------------------------------------------------------------------
# Check for root privileges.
#---------------------------------------------------------------------
check_root() {
  if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root. Use sudo or switch to root." >&2
    exit 1
  fi
}

#---------------------------------------------------------------------
# Usage: Display help message.
#---------------------------------------------------------------------
usage() {
  cat <<EOF
Usage: $0 [OPTIONS]

Use this script to install and configure packages on Fedora-based systems.

Options:
  -a    Do everything (execute all additional functions).
  -F    Install Flatpak packages.
  -l    Install Librewolf browser.
  -q    Install Qtile packages.
  -b    Install Brave Browser.
  -r    Enable RPM Fusion repositories.
  -s    Setup system services (borgbackup, trash-cli).
  -d    Speed up DNF ( e.g max_parallel_downloads=10 etc. )
  -x    Swap ffmpeg-free with ffmpeg.
  -f    Overwrite configuration files (boot(timeout=0), GDM(autologin qtile), tcp-bbr, sudoers(timeout password).
  -h    Display this help message.

Example:
  sudo $0 -a
EOF
  exit 1
}

#---------------------------------------------------------------------
# Package arrays.
#---------------------------------------------------------------------
CORE_PACKAGES=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh
  vim
  ufw                  # Firewall; Fedora defaults to firewalld
  zoxide               # Enhanced directory navigation
  eza                  # Modern ls replacement
  fd-find              # Faster file search
  trash-cli            # Command-line trash utility
  lm_sensors           # Hardware sensor monitoring
  htop                 # Process viewer
  btop                 # Resource monitor
  pip                  # Python package installer
  keepassxc            # Password manager
  seahorse             # GNOME keyring manager
  neovim               # Modern text editor
  vim                  # Text editor
  luarocks             # Lua package manager
  cargo                # Rust package manager
  bash-language-server # Bash language server
  virt-manager         # Virtualization manager
  libvirt              # Virtualization toolkit
  syncthing            # File synchronization
  borgbackup           # Backup utility
  nvidia-open          # Nvidia drivers (open variant)
)

FLATPAK_PACKAGES=(
  org.signal.Signal
  io.github.martchus.syncthingtray
  com.spotify.Client
  com.tutanota.Tutanota
)

#---------------------------------------------------------------------
# Function: install_core_packages
# Description: Update repositories and install core packages via dnf.
#---------------------------------------------------------------------
install_core_packages() {
  echo "Updating repositories..."
  dnf update -y

  echo "Installing core packages..."
  for pkg in "${CORE_PACKAGES[@]}"; do
    echo "Installing $pkg..."
    dnf install -y "$pkg"
  done
  echo "Core packages installation completed."
}

#---------------------------------------------------------------------
# Function: install_flatpak_packages
# Description: Installs packages via Flatpak from Flathub.
#---------------------------------------------------------------------
install_flatpak_packages() {
  echo "Installing Flatpak packages..."
  for pkg in "${FLATPAK_PACKAGES[@]}"; do
    echo "Installing $pkg via Flatpak..."
    flatpak install -y flathub "$pkg"
  done
  echo "Flatpak packages installation completed."
}

#---------------------------------------------------------------------
# Function: install_librewolf
# Description: Installs Librewolf by adding its repository.
#---------------------------------------------------------------------
install_librewolf() {
  echo "Installing Librewolf..."
  curl -fsSL https://repo.librewolf.net/librewolf.repo | pkexec tee /etc/yum.repos.d/librewolf.repo >/dev/null
  dnf install -y librewolf
  echo "Librewolf installation completed."
}

#---------------------------------------------------------------------
# Function: install_qtile_packages
# Description: Installs packages required for a Qtile desktop setup.
#---------------------------------------------------------------------
install_qtile_packages() {
  echo "Installing Qtile packages..."
  local qtile_packages=(
    feh
    picom
    rofi
    qtile-extras
    lxappearance
    gdm # Display manager; adjust if switching
    gammastep
    numlockx
    dunst
    flameshot
    playerctl
    xev # X event viewer
  )
  for pkg in "${qtile_packages[@]}"; do
    echo "Installing $pkg..."
    dnf install -y "$pkg"
  done
  echo "Qtile packages installation completed."
}

#---------------------------------------------------------------------
# Function: modify_brave_desktop
# Description: Appends "--password-store basic" to the Exec line in
#              brave-browser.desktop so that Brave starts with that flag.
#---------------------------------------------------------------------
modify_brave_desktop() {
  local desktop_file="/usr/share/applications/brave-browser.desktop"
  if [[ ! -f "$desktop_file" ]]; then
    echo "Error: $desktop_file not found. Please check the path."
    return 1
  fi

  # Check if the parameter is already present.
  if grep -q -- "--password-store basic" "$desktop_file"; then
    echo "Brave desktop file already contains '--password-store basic'."
  else
    # Use sed to insert the argument after the binary path.
    sed -i 's|^\(Exec=.*brave-browser-stable\)\(.*\)|\1 --password-store basic\2|' "$desktop_file"
    echo "Modified $desktop_file to include '--password-store basic'."
  fi
}
#---------------------------------------------------------------------
# Function: install_brave
# Description: Installs Brave Browser by adding its repository.
#---------------------------------------------------------------------
install_brave() {
  echo "Installing Brave Browser..."
  dnf install -y dnf-plugins-core
  echo "Adding Brave Browser repository..."
  dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
  dnf install -y brave-browser
  echo "Brave Browser installation completed."

  echo "Modifying Brave Browser desktop file for password-store basic..."
  modify_brave_desktop
}

#---------------------------------------------------------------------
# Function: enable_rpm_fusion
# Description: Enables RPM Fusion free and nonfree repositories.
#---------------------------------------------------------------------
enable_rpm_fusion() {
  echo "Enabling RPM Fusion repositories..."
  local fedora_version
  fedora_version=$(rpm -E %fedora)
  dnf install -y \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${fedora_version}.noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${fedora_version}.noarch.rpm"
  dnf upgrade --refresh -y
  dnf group upgrade -y core
  dnf install -y rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted dnf-plugins-core
  echo "RPM Fusion repositories enabled."
}

#---------------------------------------------------------------------
# Function: service_setup
# Description: Sets up and enables systemd services for borgbackup and trash-cli.
#---------------------------------------------------------------------
service_setup() {
  echo "Setting up services for borgbackup and trash-cli..."
  cp /home/developer/Documents/scripts/desktop/borg/borgbackup-home.timer /etc/systemd/system/borgbackup-home.timer
  cp /home/developer/Documents/scripts/desktop/borg/borgbackup-home.service /etc/systemd/system/borgbackup-home.service
  cp /home/developer/Documents/scripts/desktop/trash-cli.service /etc/systemd/system/trash-cli.service
  cp /home/developer/Documents/scripts/desktop/trash-cli.timer /etc/systemd/system/trash-cli.timer
  systemctl enable --now borgbackup-home.timer
  systemctl enable --now trash-cli.timer
  echo "Service setup completed."
}

#---------------------------------------------------------------------
# Function: speed_up_dnf
# Description: Tweaks DNF configuration to improve performance by appending
#              pkg_gpgcheck and max_parallel_downloads settings.
#---------------------------------------------------------------------
speed_up_dnf() {
  echo "Configuring DNF for improved performance..."
  local dnf_conf="/etc/dnf/dnf.conf"
  # Backup current dnf.conf if no backup exists.
  if [[ ! -f "${dnf_conf}.bak" ]]; then
    cp "$dnf_conf" "${dnf_conf}.bak"
  fi
  # Append settings if not already present.
  grep -q '^max_parallel_downloads=10' "$dnf_conf" || echo 'max_parallel_downloads=10' >>"$dnf_conf"
  grep -q '^pkg_gpgcheck=1' "$dnf_conf" || echo 'pkg_gpgcheck=1' >>"$dnf_conf"
  echo "DNF configuration updated."
}

#---------------------------------------------------------------------
# Function: ffmpeg_swap
# Description: Swaps ffmpeg-free with ffmpeg if ffmpeg-free is installed.
#---------------------------------------------------------------------
ffmpeg_swap() {
  echo "Checking for ffmpeg-free package..."
  if dnf list installed ffmpeg-free &>/dev/null; then
    echo "Swapping ffmpeg-free with ffmpeg..."
    dnf swap ffmpeg-free ffmpeg --allowerasing -y
    echo "ffmpeg swap completed."
  else
    echo "ffmpeg-free is not installed; skipping swap."
  fi
}

#---------------------------------------------------------------------
# Function: setup_files
# Description: Overwrites configuration files with custom settings.
#
# This function performs the following:
#   1. Overwrites the boot file to set GRUB_TIMEOUT=0 and regenerates GRUB config.
#   2. Overwrites /etc/gdm/custom.conf with custom GDM settings.
#   3. Overwrites /etc/sysctl.d/99-tcp-bbr.conf with custom TCP/network settings and reloads sysctl.
#   4. Creates/overwrites a sudoers snippet to increase the terminal password prompt timeout.
#---------------------------------------------------------------------
setup_files() {
  echo "Setting up configuration files..."

  # 1. Boot configuration.
  local boot_file="/etc/default/boot"
  echo "Overwriting boot configuration ($boot_file) with GRUB_TIMEOUT=0..."
  echo "GRUB_TIMEOUT=0" >"$boot_file"
  echo "Regenerating GRUB configuration..."
  grub2-mkconfig -o /boot/grub2/grub.cfg

  # 2. GDM custom configuration.
  local gdm_custom="/etc/gdm/custom.conf"
  echo "Overwriting GDM configuration ($gdm_custom)..."
  cat <<EOF >"$gdm_custom"
[daemon]
WaylandEnable=false
DefaultSession=qtile.desktop
AutomaticLoginEnable=True
AutomaticLogin=developer
EOF

  # 3. Network settings for TCP/BBR.
  local tcp_bbr="/etc/sysctl.d/99-tcp-bbr.conf"
  echo "Overwriting network settings ($tcp_bbr)..."
  cat <<EOF >"$tcp_bbr"
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
net.core.wmem_max=104857000
net.core.rmem_max=104857000
net.ipv4.tcp_rmem=4096 87380 104857000
net.ipv4.tcp_wmem=4096 87380 104857000
EOF
  echo "Reloading sysctl settings..."
  sysctl --system

  # 4. Sudoers snippet to increase terminal password prompt timeout.
  local sudoers_file="/etc/sudoers.d/terminal_timeout"
  echo "Creating/updating sudoers snippet ($sudoers_file)..."
  cat <<EOF >"$sudoers_file"
## Increase timeout on terminal password prompt
Defaults timestamp_type=global
Defaults env_reset,timestamp_timeout=20
EOF
  chmod 0440 "$sudoers_file"

  echo "Configuration files have been updated."
}

#---------------------------------------------------------------------
# Main function: Always installs core packages, then processes options.
#---------------------------------------------------------------------
main() {
  check_root

  # Quick check for help options
  if [[ "$#" -eq 1 && "$1" == "-h" ]]; then
    usage
  fi

  # Initialize option flags.
  all_option=false
  flatpak_option=false
  librewolf_option=false
  qtile_option=false
  brave_option=false
  rpm_option=false
  service_option=false
  dnf_speed_option=false
  swap_ffmpeg_option=false
  config_option=false

  # Process command-line options.
  while getopts "aFlqbrsdxfh" opt; do
    case $opt in
    a) all_option=true ;;
    F) flatpak_option=true ;;
    l) librewolf_option=true ;;
    q) qtile_option=true ;;
    b) brave_option=true ;;
    r) rpm_option=true ;;
    s) service_option=true ;;
    d) dnf_speed_option=true ;;
    x) swap_ffmpeg_option=true ;;
    f) config_option=true ;;
    h) usage ;;
    *) usage ;;
    esac
  done

  # If no optional flags were provided, show usage and exit.
  if ! $flatpak_option && ! $librewolf_option && ! $qtile_option &&
    ! $brave_option && ! $rpm_option && ! $service_option &&
    ! $dnf_speed_option && ! $swap_ffmpeg_option && ! $config_option; then
    usage
  fi

  # Determine if core packages are needed
  local need_core_packages=false
  if $all_option || $qtile_option || $service_option; then
    need_core_packages=true
  fi

  # Optimze DNF if core packages are required
  # or the user has selected the DNF speed option.
  if $need_core_packages || $dnf_speed_option; then
    speed_up_dnf
  fi

  # Install core packages.
  if $need_core_packages; then
    install_core_packages
  fi

  if $all_option; then
    echo "Executing all additional functions..."
    install_flatpak_packages
    install_librewolf
    install_qtile_packages
    install_brave
    enable_rpm_fusion
    service_setup
    ffmpeg_swap
    setup_files
  else
    if $flatpak_option; then install_flatpak_packages; fi
    if $librewolf_option; then install_librewolf; fi
    if $qtile_option; then install_qtile_packages; fi
    if $brave_option; then install_brave; fi
    if $rpm_option; then enable_rpm_fusion; fi
    if $service_option; then service_setup; fi
    if $dnf_speed_option; then speed_up_dnf; fi
    if $swap_ffmpeg_option; then ffmpeg_swap; fi
    if $config_option; then setup_files; fi
  fi
}

# Execute main with provided command-line arguments.
main "$@"
