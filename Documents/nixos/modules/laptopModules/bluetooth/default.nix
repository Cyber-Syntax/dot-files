{
  services.blueman.enable = true; # gui
  hardware.bluetooth = {
    enable = true;
    #powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket"; # enable A2DP for modern headsets
        # Enabling it may prevent some Bluetooth mice from connecting automatically
        Experimental = true; # show battery charge
      };
    };
  };
}
