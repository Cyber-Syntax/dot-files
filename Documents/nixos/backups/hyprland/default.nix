{ pkgs, ... }:

{
  #NOTE: so much things to do... Backlog now.
  #TODO: learn uwsm, setup uwsm on hypr confs...
  programs = {
    hyprland.enable = true;
    hyprland.xwayland.enable = true;
    hyprlock.enable = true;
    #NOTE: If you use the Home Manager module, make sure to disable the systemd integration, as it conflicts with uwsm.
    uwsm.enable = true;
    uwsm.waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
    hyprland.withUWSM.enable = true;
  };

}
