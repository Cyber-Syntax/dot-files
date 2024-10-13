{ ... }:

{
  services = { # lightdm, qtile, xserver
    displayManager = {
     defaultSession = "qtile";
     autoLogin.enable = true;  #NOTE: ctrl + alt + F1,2,3,4 still works
     autoLogin.user = "developer";
    };
    
    xserver = {
      enable = true;
      xkb.layout = "tr";
      autorun = true;
      exportConfiguration = true;

      displayManager = { # Lightdm
        lightdm.enable = true;
        lightdm.extraConfig = ''
          [Seat:*]
          greeter-setup-script=/usr/bin/setxkbmap -layout tr
          '';
      };

      windowManager.qtile = { 
        enable = true;
        # This one symlink only config.py instead of all the other files inside qtile folder.                                             
        #configFile = /home/developer/Documents/nixos/hosts/desktop/qtile;            
         extraPackages = python3Packages: with python3Packages; [
            qtile-extras
          ];
      };
      
    }; #./xserver
  }; ### ./services
}
