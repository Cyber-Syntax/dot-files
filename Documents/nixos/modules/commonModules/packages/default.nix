{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    xorg.setxkbmap
    xorg.xrandr
    xorg.xhost
    xorg.xev
    xorg.xkbcomp
    xorg.xkill
    xorg.xwininfo
    xorg.xinit
    xorg.xauth
    # Main apps
    vim
    ripgrep # for obsidian.nvim plugin
    networkmanagerapplet # for nm-applet
    unzip
    acpi
    xdg-user-dirs
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    ## Stats, system infos etc.
    lm_sensors
    fastfetch
    powertop # battery usage etc.
    htop
    ## basic developer tools
    wget
    git
    gh # github cli
    ## Sound music etc.
    alsa-utils
    playerctl
    easyeffects
    pulseaudio
    pavucontrol
    ## theme
    materia-theme
    ## X11, window manager
    i3lock
    rofi
    dunst
    gammastep
    picom
    xclip # for copy paste in neovim
    ## Productivity
    zoxide
    trash-cli
    eza # modern ls
    duf # modern du
    bat # modern cat
    fd # modern find
    tldr # modern man
    numlockx
    ## Development
    # Coding
    nodejs_22
    hugo
    go
    lua
    # neovim
    lazygit
    gnumake
    #vscode-json-languageserver
    lua-language-server
    bash-language-server
    luarocks # for lua
    stylua # lua formatter
    marksman
    ruff # python linter
    pylint # static code analysis tool for python
    ## AI
    python311Packages.litellm
    python311Packages.tokenizers
    python3
    ### Development for compiling
    clang
    libgcc
    libstdcxx5 # for litellm
    ### encryption
    openssl
    ### other
    xdotool
    # Nixos
    nix-prefetch # get hash from github branches
    nix-prefetch-git
    nix-prefetch-github
    nurl
    home-manager
    nil # nix language server as lsp
    cargo # for rust and nil to work
    # Apps
    ## Pictures, Documents etc.
    feh
    gimp
    evince
    calibre
    libreoffice
    flameshot
    xournalpp
    pcmanfm
    ## email
    thunderbird
    tutanota-desktop
    birdtray
    ## Nextcloud packages
    nextcloud-client
    wakeonlan
    ## Disk
    gparted
    ## backup
    rclone
    borgbackup
    syncthingtray
    ## Browser
    brave
    firefox
    ungoogled-chromium
    ## Password manager
    keepassxc
    ## Chat
    signal-desktop
    ## Terminal
    kitty

    ## My best apps
    #TEST: unstable version is in use
    freetube

    ## for windows
    ntfs3g
    ## My unfree apps
    obsidian
    spotify
    # Test
    traceroute
    btop
    bash-completion
    bashInteractive
    nix-bash-completions
  ];
}
