{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    #TESTING: migrating the folder hiararchy e.g default.nix
    ./../../modules/commonModules/default.nix

    #TESTING: xdg in test.
    ./../../home-manager/default.nix

    # overlays
    ./../../overlays/default.nix

    # laptop ../../modules
    ./../../modules/laptopModules/default.nix
  ];

  # Luks encryption support
  boot.initrd.systemd.enable = true;

  #iptables -A nixos-fw -p udp --source 192.168.1.39 --dport 1:65535 -j nixos-fw-accept || true
  networking = {
    hostName = "nixosLaptop";

    #TODO: Enable after default 22 port is rejected
    #iptables -A INPUT -p tcp -s 192.168.1.39/24 --dport 22 -j ACCEPT
    # firewall = {
    #   extraCommands = ''
    #     iptables -I INPUT -p tcp --dport 22 -s 192.168.1.39 -j ACCEPT
    #   '';
    # };
  };

  users.users.developer = {
    isNormalUser = true;
    description = "developer";
    extraGroups = [
      # "backlight"
      "networkmanager"
      "wheel"
      "libvirtd"
      "video"
      "kvm"
    ];
  };

  # TODO: setup hardware for laptop
  # set this if tlp not able to handle it
  #NOTE: if max freq is is 400mhz on battery disable Intel SpeedStep in the BIOS
  # seems like tlp already handle this to powersave and ondemand is not work anymore on linux
  # powerManagement.cpuFreqGovernor = ""; # ondemand, performance, powersave
  #NOTE: THIS IS NOT WORKING on i5-13th gen yet
  #NOTE: https://github.com/erpalma/throttled/issues?q=13th
  #TEST: some of the user tested and used but have issue with tlp.

  #BUG: i5-1335U not supported yet.
  # throttled.enable = true; # fix for intel cpu throttling on thinkpads

  services = {
    syncthing = {
      enable = true;
      group = "syncthing"; # default
      user = "developer"; # cause permission issues if not set to user
      configDir = "/home/developer/.config/syncthing";
      guiAddress = "127.0.0.1:8384"; # default

      relay.enable = false; # default, syncthing relay server is used via connecting other relay servers. Not local.
      #TODO: is already use this default?
      #relay.listenAddress = "tcp4://:22000" # only ipv4
      systemService = true; # Whether to auto-launch Syncthing as a system service.

      # Whether to delete the folders which are not configured via the folders option. If set to false, folders added via the web interface will persist and will have to be deleted manually.
      overrideFolders = true; # default
      #Whether to delete the devices which are not configured via the devices option. If set to false, devices added via the web interface will persist and will have to be deleted manually.
      overrideDevices = true; # default
      # Note that you can still add folders manually, but those changes will be reverted on restart if overrideFolders is enabled.
      #TODO: Test later after normal syncthing setup via .config.
      # Make sure you use without global discovery server and relay servers.
      # settings.options.localAnnounceEnabled = true; # Whether to send announcements to the local LAN, also use such announcements to find other devices.
      # # TESTING:
      # settings.folders = {
      #   {
      #     "test" = { # looks like folder name for syncthing not path
      #       path = "~/test";
      #       id = "test";
      #       devices = [ "My Phone" ];
      #       type = "sendreceive";
      #       versioning = [
      #         {
      #           versioning = {
      #             type = "simple";
      #             params.keep = "5";
      #           };
      #         }
      #       ];
      #     };#.test folder
      #   }
      # };
      #
      #
      # settings.devices = {
      #   My Phone = {
      #     addresses = [
      #       "tcp://192.168.1.45:22000"
      #     ];
      #     id = "WNMYT36-42FPWK";
      #   };
      # };

      #NOTE: I already setup manually on network but maybe this would be useful
      #openDefaultPorts = true; # open defualt ports if you use one user in this machine.
    }; # ./syncthing
  }; # ./services

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
