{ config, pkgs, lib,... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
 
      # desktop modules
      ./../../modules/desktopModules/nvidia.nix
      ./../../modules/desktopModules/ollama.nix

      # common modules 
      ./../../modules/commonModules/qtile.nix
      ./../../modules/commonModules/i18n.nix
      ./../../modules/commonModules/neovim.nix
      ./../../modules/commonModules/fonts.nix
      ./../../modules/commonModules/programs.nix
      ./../../modules/commonModules/security.nix
      ./../../modules/commonModules/services.nix
      ./../../modules/commonModules/appimages.nix
      ./../../modules/commonModules/packages.nix
      
      # Home-Manager used via nix builds. 
      ./../../home-manager/shell/zsh.nix
      #./home-manager/neovim.nix # chadrc error.
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
    
      hosts = {
        "192.168.1.60" = ["nextcloud"];
        "192.168.1.107" = ["laptop"];
      };
    
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

### USERS SETUP
  users.users.developer = {
    isNormalUser = true;
    description = "developer";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "video" "kvm"];
    packages = with pkgs; [];
  };


### Virtulization
virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;

services = {
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

