{ pkgs, ... }:

{
  services = {
    #NOTE: SESSION:QTILE, SDDM, Autologin
    displayManager = {
      defaultSession = "qtile";
      #NOTE: unstable work with this on x11
      # sessions-directory = /nix/store/vkwfxdca6z8hh3zwrd7xd487wr16z0wl-desktops/share/xsessions:/nix/store/vkwfxdca6z8hh3zwrd7xd487wr16z0wl-desktops/share/wayland-sessions
      autoLogin.enable = true; # NOTE: ctrl + alt + F1,2,3,4 still works
      autoLogin.user = "developer";

      sddm = {
        enable = true;
        autoNumlock = true;
      };
    };
  }; # ## ./services
}
