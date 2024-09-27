{ config, pkgs, lib,... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
 
      # desktop ../../modules

      # common ../../modules 
      ./../../modules/commonModules/qtile.nix
      ./../../modules/commonModules/i18n.nix
      ./../../modules/commonModules/neovim.nix
      ./../../modules/commonModules/fonts.nix
      ./../../modules/commonModules/programs.nix
      ./../../modules/commonModules/security.nix
      ./../../modules/commonModules/services.nix
      ./../../modules/commonModules/appimages.nix
      
      # Home-Manager used via nix builds. 
      ./../../home-manager/zsh.nix 
      #./home-manager/neovim.nix # chadrc error.
    ];

  # Bootloader.
  boot.initrd.systemd.enable = true;

  boot = {
   
    kernelPackages = pkgs.linuxPackages_latest; # Use latest stable Linux
    loader = {
      systemd-boot = {
        enable = true;
        #timeout = 5;
        #defaultKernelOptions = [ "quiet" ];
          configurationLimit = 50;
      };

      efi = {
        canTouchEfiVariables = true;
        #systemPartition = "/boot";
      };
    };

    # reno cubic enabled: 83-89down 18-19up
    # after bbr enabled: 89-93down 18-20up
    kernelModules = ["tcp_bbr"]; # Enable BBR congestion control algorithm.
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "fq";
      "net.core.wmem_max" = 104857000; # 100Mib
      "net.core.rmem_max" = 104857000; # 100Mib
      "net.ipv4.tcp_rmem" = "4096 87380 104857000"; # 4Kib 87Kib 100Mib
      "net.ipv4.tcp_wmem" = "4096 87380 104857000"; # 4Kib 87Kib 100Mib
    };
      
  };

### NETWORK
  networking = {
    # Enable the NetworkManager
    networkmanager.enable = true;
    # Define your hostname.
    hostName = "nixosLaptop";
    
    
    ### FIREWALL 
      firewall = {
      enable = true;
      allowPing = false; # decline ICMP pings 
      # allow syncthing
      allowedTCPPorts = [ 8384 22000];
      allowedUDPPorts = [ 22000 21027 ];
      # allowedUDPPortRanges = [
      #   { from = 4000; to = 4007; }
      #   { from = 8000; to = 8010; }
      # ];
      
      # Allow my laptop to connect to my desktop 192.168.1.107
      #iptables -D nixos-fw -p tcp --source 192.0.2.0/24 --dport 1714:1764 -j nixos-fw-accept || true 
      extraCommands = '' 
          iptables -A nixos-fw -p udp --source 192.168.1.39 --dport 1:65535 -j nixos-fw-accept || true
          iptables -A nixos-fw -p tcp --source 192.168.1.39 --dport 1:65535 -j nixos-fw-accept || true

        '';
    };
  };
  # https://nixos.org/manual/nixos/stable/#sec-wireless
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

###nix

nix = {
  daemonCPUSchedPolicy = "batch"; #medium=batch, default: high=other, low=idle
  daemonIOSchedClass = "idle"; #high=best-effort, low=idle
  daemonIOSchedPriority = 4; #default=4, 0 high, 7 low
    # add overlays-compat
    #nixPath = [ "/home/developer/Documents/nixos/overlays-compat/"];

    # nixos garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
      persistent = true; # Default = true. This make systemd timer persistent if missed the last start time, similar anacron
    };
  
    settings = {
      warn-dirty = false;
      use-xdg-base-directories = true;
      builders-use-substitutes = true;
      max-substitution-jobs = 20;
      auto-optimise-store = true;
      
      allowed-users = [ "developer" "@wheel"];
      experimental-features = ["nix-command" "flakes"];

      substituters = [
        "https://cache.nixos.org/"
        
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];

    }; 
};
#performance cause problem with amd 2600x CPU. amd_pstate driver is not supported with this CPU.(Zen+)
# only zen2 and newer support this amd_pstate driver.
 powerManagement.cpuFreqGovernor = "ondemand"; # ondemand, performance, powersave
 # battery management
 services.tlp.enable = true;

### USERS SETUP
  users.users.developer = {
    isNormalUser = true;
    description = "developer";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "video" "kvm"];
    packages = with pkgs; [];
  };

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
  ];

### Virtulization
#virtualisation.libvirtd.enable = true;
#programs.virt-manager.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

