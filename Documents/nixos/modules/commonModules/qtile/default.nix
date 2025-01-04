{ pkgs, ... }:

{
  # systemd.user.targets.qtile-session = {
  #     description = "Qtile compositor session";
  #     documentation = [ "man:systemd.special(7)" ];
  #     bindsTo = [ "graphical-session.target" ];
  #     wants = [ "graphical-session-pre.target" ];
  #     after = [ "graphical-session-pre.target" ];
  #   };

  # #TODO: Wayland enable
  # environment.variables = {
  #   MOZ_DISABLE_RDD_SANDBOX = "1";
  #   NIXOS_OZONE_WL = "1";
  # };
  #
  services = {
    xserver = {
      enable = true;
      xkb.layout = "tr";
      autorun = true;
      exportConfiguration = true;

      windowManager.qtile = {
        enable = true;
        extraPackages =
          python3Packages: with python3Packages; [
            qtile-extras
          ];
      };

    }; # ./xserver
  }; # ## ./services
}
