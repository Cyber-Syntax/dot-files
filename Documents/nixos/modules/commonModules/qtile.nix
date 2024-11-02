{ pkgs, ... }:

{
# systemd.user.targets.qtile-session = {
#     description = "Qtile compositor session";
#     documentation = [ "man:systemd.special(7)" ];
#     bindsTo = [ "graphical-session.target" ];
#     wants = [ "graphical-session-pre.target" ];
#     after = [ "graphical-session-pre.target" ];
#   };

  services = { # lightdm, qtile, xserver
    displayManager = {
      defaultSession = "qtile";
      # unstable work with this on x11 
      # sessions-directory = /nix/store/vkwfxdca6z8hh3zwrd7xd487wr16z0wl-desktops/share/xsessions:/nix/store/vkwfxdca6z8hh3zwrd7xd487wr16z0wl-desktops/share/wayland-sessions
     autoLogin.enable = true;  #NOTE: ctrl + alt + F1,2,3,4 still works
     autoLogin.user = "developer";

 #   sddm because lightdm cause issue on 24.05
      sddm = {
        enable = true;
        autoNumlock = true;
      };
    };
    
    xserver = {
      enable = true;
      xkb.layout = "tr";
      autorun = true;
      exportConfiguration = true;

      displayManager = { # Lightdm
   #    lightdm.enable = true;
        # session = [ 
        #   { 
        #     manage = "desktop";
        #     name = "qtile";
        #     start = ''
        #       exec qtile start &
        #       waitPID=$!
        #     '';
        #   }
        # ];

        # lightdm.extraConfig = ''
        #   greeter-setup-script=/usr/bin/setxkbmap -layout tr
        #   logind-check-graphical=true
        #   '';
      };

      windowManager.qtile = { 
       enable = true;
       extraPackages = python3Packages: with python3Packages; [
          qtile-extras
        ];
      };
      
    }; #./xserver
  }; ### ./services
}
