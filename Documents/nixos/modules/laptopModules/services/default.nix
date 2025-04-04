{
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
}
