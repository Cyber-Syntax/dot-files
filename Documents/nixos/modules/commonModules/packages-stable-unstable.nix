{ pkgs, unstable, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = (with pkgs; [
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
        # Coding
          nodejs_22
          hugo
          go
          lua 
          lua-language-server
          #vscode-json-languageserver 
        ## AI
          python311Packages.litellm
          python311Packages.tokenizers
          python3
        ### Development for compiling
          clang
          libgcc
          libstdcxx5  # for litellm
      ### encryption
        openssl
      ### other
        xdotool
      # Nixos
        nix-prefetch # get hash from github branches 
        home-manager
        nil # nix language server as lsp
        cargo # for rust and nil to work
  ]) ++ (with unstable; [
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
        kitty
      ## My best apps
        freetube
      ## for windows
        ntfs3g
      ## My unfree apps
        obsidian
        spotify  
  ]);
}
