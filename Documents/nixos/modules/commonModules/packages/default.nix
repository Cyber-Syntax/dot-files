{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Main apps
    libsecret # for seahorse and gpg
    pciutils
    vim
    ripgrep # for obsidian.nvim plugin
    networkmanagerapplet # for nm-applet
    unzip
    acpi
    xdg-user-dirs
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    ## Stats, system infos etc.
    powertop
    lm_sensors
    fastfetch
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
    rofi
    dunst
    #FIX: wayland is not work on gammastep
    gammastep
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
    # nodejs_22
    nodePackages_latest.nodejs
    yarn
    hugo
    go
    lua
    # neovim
    lazygit
    gnumake
    cargo # for rust and nil to work
    lua-language-server
    luarocks # for lua
    stylua # lua formatter
    marksman
    vimPlugins.vim-markdown-toc
    markdownlint-cli2
    #python
    ruff
    mypy
    #nix
    nil
    nixd
    # nixfmt-rfc-style
    alejandra
    statix
    #bash, shell
    bash-language-server
    #json
    #json-lsp #FIX: find correct name
    #Other
    stdenv.cc.cc.lib
    zlib
    # html
    prettierd # TODO: need setup on neovim
    nodePackages.prettier
    yamlfmt
    bash-language-server
    # pylint # static code analysis tool for python
    ## AI
    python3
    ### Development for compiling
    clang
    libgcc
    ### encryption
    openssl
    # Nixos
    nix-prefetch # get hash from github branches
    nix-prefetch-git
    nix-prefetch-github
    nurl
    home-manager
    # Apps
    ## Pictures, Documents etc.
    feh
    gimp
    evince
    calibre
    libreoffice
    xournalpp
    pcmanfm
    ## email
    # birdtray # tray for thunderbird
    thunderbird
    ## Nextcloud packages
    nextcloud-client
    wakeonlan
    ## Disk
    gparted
    ## backup
    # rclone
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
    freetube

    ## My unfree apps
    obsidian
    spotify
    # Test
    traceroute
    btop
    bash-completion
    bashInteractive
    nix-bash-completions

    #VPN works now with the below packages
    protonvpn-gui # cli not supported anymore
    wireguard-tools

    # manual setup without proton gui
    networkmanager-openvpn
    openvpn

    #TESTING:
    killall
  ];
}
