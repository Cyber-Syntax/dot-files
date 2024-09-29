{ pkgs, ... }:
{
### PACKAGES 
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # xorg
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
      networkmanagerapplet # for nm-applet
      unzip
      acpi
      xdg-user-dirs
      ## Stats, system infos etc.
        lm_sensors
        fastfetch
        htop
      ## basic developer tools
        wget
        git    
      ## Sound music etc.
        alsa-utils
        playerctl
        #easyeffects
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
        xclip # for copy paste
    ## Productivity
      zoxide
      trash-cli
      numlockx
    ## Development 
      nodejs_22
      hugo
      go
      ### Development for compiling
        clang
        libgcc
        libstdcxx5  # for litellm
    ### encryption
      openssl
    ### other
      xdotool
    ## AI
      python311Packages.litellm
      python311Packages.tokenizers
      python3
    # Nixos
      nix-prefetch # get hash from github branches 
      home-manager
      nil # nix language server as lsp
      cargo # for rust
    # Apps
      ## Pictures, Documents etc.
        feh
        gimp
        evince
        calibre
        libreoffice
        flameshot
        fluent-reader
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
        oh-my-posh
        kitty
      ## My best apps
        freetube
      ## for windows
        ntfs3g
      ## My unfree apps
        obsidian
        spotify
  ];
}
