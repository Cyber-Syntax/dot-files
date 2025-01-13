{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    #TESTING: migrating the folder hiararchy e.g default.nix
    ./../../modules/commonModules/default.nix

    #TESTING: xdg added newly it can be cause issues!!
    ./../../home-manager/default.nix

    ./../../overlays/default.nix

    #TODO: use this if flake won't work.
    #inputs.nixos-hardware.outputs.nixosModules.common-cpu-amd

    ./../../modules/desktopModules/default.nix

    # Specific versions from github.
    ./../../derivations/default.nix
  ];

  networking = {
    hostName = "nixos";

    #TODO: Enable after default 22 port is rejected
    # firewall = {
    #   extraCommands = ''
    #     iptables -I INPUT -p tcp --dport 22 -s 192.168.1.107 -j ACCEPT
    #   '';
    # };
  };

  ### Windows dualboot time date problem solve:
  #time.hardwareClockInLocalTime = true; # Didn't solve superProductivity date/time issue

  #performance cause problem with amd 2600x CPU. amd_pstate driver is not supported with this CPU.(Zen+)
  # only zen2 and newer support this amd_pstate driver.
  # TODO: testing common-cpu-amd on flakes
  # cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors
  # performance, powersave on my cpu AMD Ryzen 5 5600X
  powerManagement.cpuFreqGovernor = "performance"; # ondemand, performance, powersave

  users.users.developer = {
    isNormalUser = true;
    description = "developer";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "video"
      "kvm"
    ];
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
      prune.keep = {
        # prune and keep only 13 backups
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
  system.stateVersion = "24.11"; # Did you read the comment?
}
