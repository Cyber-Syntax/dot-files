{config, lib, pkgs, ... }:

{
### X11, displayManager, windowManager, videoDriver
  ## services #
  services = {
    #  getty.autologinUser = "developer";
      libinput.enable = false; # for syncaptics touchpads
     
    ##### Qtile, X11, Light #####
      displayManager = {
       defaultSession = "qtile"; 
       autoLogin.enable = true; 
       autoLogin.user = "developer";
      };
    ### ./Qtile, X11, Light ####
      ## xserver #
      xserver = {
        enable = true;
        xkb.layout = "tr";
        
        # # startx for testing
        # autorun = false; # TODO: Testing startx for now
        # displayManager.startx.enable = true;
        #

        ## LightDM ###
          displayManager = {
            lightdm.enable = true;
            # lightdm keyboard layout
            lightdm.extraConfig = ''
              [Seat:*]
              greeter-setup-script=/usr/bin/setxkbmap -layout tr
              '';
          };
        ## ./lightdm ###

        ## QTILE stable version for now. #
          windowManager.qtile = {
            enable = true;
           
             extraPackages = python3Packages: with python3Packages; [
                qtile-extras
              ];
          };
        ## ./Qtile, X11, Light ####

          autorun = true;
          exportConfiguration = true;
          videoDrivers = ["nvidia"];
      };
      #./xserver #
    };
  # ./qtile #

}
