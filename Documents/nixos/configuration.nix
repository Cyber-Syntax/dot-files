# Edit this configuration file to define what should be installed on

# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib,... }:


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/qtile.nix
      ./modules/nvidia.nix
      ./modules/ollama.nix
    ];

  # Bootloader.
  boot = {
    #TODO: Testing suspend problem on qtile with this option
    #kernelParams = [ "nvidia-drm.modeset=1" ];
   
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
    hostName = "nixos";
    
      # hosts = {
      #   "192.168.1.60" = ["nextcloud.local"];
      # };
    
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
          iptables -A nixos-fw -p udp --source 192.168.1.107 --dport 1:65535 -j nixos-fw-accept || true
          iptables -A nixos-fw -p tcp --source 192.168.1.107 --dport 1:65535 -j nixos-fw-accept || true

        '';
    };
  };
  # https://nixos.org/manual/nixos/stable/#sec-wireless
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";



  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };
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
      
      allowed-users = [ "developer" "cyber-syntax""@wheel"];
      experimental-features = ["nix-command" "flakes"];

      substituters = [
        "https://cache.nixos.org/"
        #"https://nix-community.cachix.org"
        
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        #"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

    }; 
};
#performance cause problem with amd 2600x CPU. amd_pstate driver is not supported with this CPU.(Zen+)
# only zen2 and newer support this amd_pstate driver.
 powerManagement.cpuFreqGovernor = "ondemand"; # ondemand, performance, powersave
 # battery management
 # services.tlp.enable = true;



### dconf settings #
programs.dconf.enable = true;


# ./services #

  # Configure console keymap
  console.keyMap = "trq";
   
  # font	
  fonts = {
    packages = with pkgs; [
      corefonts
      liberation_ttf
      dejavu_fonts
      terminus_font
      ubuntu_font_family
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Jetbrains Mono Bold"];
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"]; 
      };
    };
  };

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
    xorg.setxkbmap
    xorg.xrandr
    xorg.xhost
    xorg.xev
    xorg.xkbcomp
    xorg.xkill
    xorg.xwininfo
    alsa-utils
    xorg.xinit
    xorg.xauth
    vim 
    wget
    networkmanagerapplet # for nm-applet
    unzip
    xclip
    htop
    acpi
    git
    picom
    fastfetch
    xdg-user-dirs
    playerctl
    lm_sensors
    pulseaudio
    numlockx
    ### Apps
    fluent-reader
    feh
    flameshot
    pavucontrol
    ### theme
    materia-theme
    ### X11, window manager
    i3lock
    rofi
    ### terminal
    gparted
    ### Productivity
    zoxide
    trash-cli
    ### Development 
    nodejs_22
    hugo
    go
    ### Development for compiling
    clang
    libgcc
    libstdcxx5  # for litellm
    ### encryption
    openssl
    ### documentation
    evince
    gimp
    ### other
    xdotool
    ## AI
      python311Packages.litellm
      python311Packages.tokenizers
      python3
    ## Nextcloud packages
    nextcloud-client
    wakeonlan

    home-manager
   
    # X11-wayland notification and bluecolor setup
      dunst
      gammastep

    #nix
    nix-prefetch # get hash from github branches 

    # apps
      pcmanfm
      brave
      firefox
      keepassxc
      signal-desktop
      ungoogled-chromium
      tutanota-desktop
      xournalpp
      libreoffice
      calibre
      borgbackup
      syncthingtray
      kitty
      #zsh
      # My best apps
      freetube
      obsidian
  ];



### Virtulization
virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;

##### PROGRAMS

### ZSH
environment.pathsToLink = ["/share/zsh"];
environment.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

### neovim

programs.neovim = {
	enable = true;
	defaultEditor = true;
};

## Security
security = {
  rtkit.enable = true;
  polkit.enable = true;
  
# Increase password timeout for sudo
# Allow access on other tty's
  sudo.extraConfig = ''
    Defaults timestamp_type=global
    Defaults env_reset,timestamp_timeout=10
  '';
};

hardware.pulseaudio.enable = false;

# sytemd-timer for trash-cli to delete files older than 30 days.
systemd.timers."trash-cli" = {
  wantedBy = [ "timers.target" ];
  timerConfig = {
    OnCalendar = "daily";
    Persistent = true;
  };
};

systemd.services."trash-cli" = {
# (crontab -l ; echo "@daily $(which trash-empty) 30") | crontab -
  script = ''
    ${pkgs.trash-cli}/bin/trash-empty 30  
  '';
  
  serviceConfig = {
    Type = "oneshot";
    #ExecStart = "${pkgs.trash-cli}/bin/trash-empty 30";
    User = "developer";
  };
};

# enable seahorse for gnome-keyring
programs.seahorse = {
  enable = true;
};


services = {
  gnome.gnome-keyring.enable = true;
  acpid.enable = true;
  dbus.enable = true;
  devmon.enable = true;
  printing.enable = false;

  fstrim.enable = true;
  fwupd.enable = true;
  smartd.enable = true;

 
  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;	
  };
  # # syncthing
  syncthing = {
    enable = true;
    user = "developer";
    #group = "developer";
    #dataDir = "/home/developer/.local/share/syncthing";
    configDir = "/home/developer/.config/syncthing";
  };

  # borgbackup
  borgbackup.jobs."home-backup" = {
    paths = "/home/developer/";
    exclude = [
      # Largest cache dirs
      ".cache"
      "*/cache2" # firefox
      "*/Cache"
      ".config/Slack/logs"
      ".config/Code/CachedData"
      ".container-diff"
      ".npm/_cacache"
      # Work related dirs
      "*/node_modules"
      "*/bower_components"
      "*/_build"
      "*/.tox"
      "*/venv"
      "*/.venv"
      "~/Downloads"
    ];
    encryption.mode = "none";
    repo = "/mnt/backups/borgbackup/home-nixos";
    compression = "zstd,15";
    # prune and keep only 13 backups
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 2;
    };
    # persistent systemd timer if missed the last start time, similar anacron
    persistentTimer = true;
    # start time Europe/Istanbul 10:00
    startAt = [ "*-*-* 10:00 Europe/Istanbul" ];
  };

  borgbackup.jobs."nixos-backup" = {
    paths = "/etc/nixos/";
    encryption.mode = "none";
    repo = "/mnt/backups/borgbackup/root-nixos";
    #doInit = true;  # cause it the make 2 backup in a day
    compression = "zstd,15";
    persistentTimer = true;
    # start time Europe/Istanbul 10:00
    startAt = [ "*-*-* 10:00 Europe/Istanbul" ];
    #prune and keep only 13 backups
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 2;
    };
    
  };
    
};


### Appimage won't work without it, appimage-run 
boot.binfmt.registrations.appimage = {
  wrapInterpreterInShell = false;
  interpreter = "${pkgs.appimage-run}/bin/appimage-run";
  recognitionType = "magic";
  offset = 0;
  mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
  magicOrExtension = ''\x7fELF....AI\x02'';
};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}

