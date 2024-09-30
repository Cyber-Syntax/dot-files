{ ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      #TODO: use this if flake won't work.
      #inputs.nixos-hardware.outputs.nixosModules.common-cpu-amd
 
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
      ./../../modules/commonModules/nix.nix
      ./../../modules/commonModules/boot.nix
      
      # Home-Manager used via nix builds. 
      ./../../home-manager/shell/zsh.nix
      #./home-manager/neovim.nix # chadrc error. 
    ];

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
      #iptables -D nixos-fw -p tcp --source 192.0.2.0/24 --dport 1714:1764 -j nixos-fw-accept || true 
      extraCommands = '' 
          iptables -A nixos-fw -p udp --source 192.168.1.107 --dport 1:65535 -j nixos-fw-accept || true
          iptables -A nixos-fw -p tcp --source 192.168.1.107 --dport 1:65535 -j nixos-fw-accept || true
        '';
    };
  };

#performance cause problem with amd 2600x CPU. amd_pstate driver is not supported with this CPU.(Zen+)
# only zen2 and newer support this amd_pstate driver.
# TODO: testing common-cpu-amd on flakes
powerManagement.cpuFreqGovernor = "ondemand"; # ondemand, performance, powersave

users.users.developer = {
  isNormalUser = true;
  description = "developer";
  extraGroups = [ "networkmanager" "wheel" "libvirtd" "video" "kvm"];
};

### Virtulization
virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;

services = {
  syncthing = {
    enable = true;
    user = "developer";
    #group = "developer";
    #dataDir = "/home/developer/.local/share/syncthing";
    configDir = "/home/developer/.config/syncthing";
  };

  borgbackup.jobs."home-backup" = {
    paths = "/home/developer/";
    exclude = [
      ".cache"
      "*/cache2" # firefox
      "*/Cache"
      ".config/Slack/logs"
      ".config/Code/CachedData"
      ".container-diff"
      ".npm/_cacache"
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
    prune.keep = { #prune and keep only 13 backups
      daily = 7;
      weekly = 4;
      monthly = 2;
    };
    persistentTimer = true; # similar anacron, if missed the last start time, start backup
    startAt = [ "*-*-* 10:00 Europe/Istanbul" ];
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

