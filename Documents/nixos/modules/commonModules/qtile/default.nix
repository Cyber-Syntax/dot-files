{ pkgs, ... }:

{
  # systemd.user.targets.qtile-session = {
  #     description = "Qtile compositor session";
  #     documentation = [ "man:systemd.special(7)" ];
  #     bindsTo = [ "graphical-session.target" ];
  #     wants = [ "graphical-session-pre.target" ];
  #     after = [ "graphical-session-pre.target" ];
  #   };

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
