{ ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
       # laptop ../../modules

      # common ../../modules 
      ./../../modules/commonModules/qtile.nix
      ./../../modules/commonModules/i18n.nix
      ./../../modules/commonModules/neovim.nix
      ./../../modules/commonModules/fonts.nix
      ./../../modules/commonModules/programs.nix
      ./../../modules/commonModules/security.nix
      ./../../modules/commonModules/services.nix
      ./../../modules/commonModules/appimages.nix
      ./../../modules/commonModules/boot.nix
      ./../../modules/commonModules/nix.nix
      ./../../modules/commonModules/packages.nix
      
      # Home-Manager used via nix builds. 
      ./../../home-manager/shell/zsh.nix
      #./home-manager/neovim.nix # chadrc error.
    ];

  # Luks encryption support
  boot.initrd.systemd.enable = true;

### NETWORK
  networking = {
    # Enable the NetworkManager
    networkmanager.enable = true;
    # Define your hostname.
    hostName = "nixosLaptop";
      
      hosts = {
        "192.168.1.60" = ["nextcloud"];
        "192.168.1.39" = ["nixos"];
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
          iptables -A nixos-fw -p udp --source 192.168.1.39 --dport 1:65535 -j nixos-fw-accept || true
          iptables -A nixos-fw -p tcp --source 192.168.1.39 --dport 1:65535 -j nixos-fw-accept || true
        '';
    };
  };

  users.users.developer = {
    isNormalUser = true;
    description = "developer";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "video" "kvm"];
  };

# TODO: setup hardware for laptop
# powerManagement.cpuFreqGovernor = "ondemand"; # ondemand, performance, powersave

# Fix thinkfan issue
systemd.services.thinkfan.preStart = "
  /run/current-system/sw/bin/modprobe  -r thinkpad_acpi && /run/current-system/sw/bin/modprobe thinkpad_acpi
";

services = {
  tlp = {
    enable = true; 
  };

  thinkfan = {
    enable = true;
  };
};

# bluetooth
hardware.bluetooth = {
  enable = true;
  #powerOnBoot = true; # TODO: check if this is needed
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

