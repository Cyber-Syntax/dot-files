# Define custom environment variables based on hostname
# You might want to configure this to handle different environments for laptop and desktop

{ config, pkgs, ... }:

let
  hostname = config.networking.hostName;
  hyprConfigDir =
    if hostname == "nixosLaptop" then
      "/home/yourusername/.config/hypr-laptop"
    else if hostname == "nixos" then
      "/home/yourusername/.config/hypr-desktop"
    else
      "/home/yourusername/.config/hypr"; # Default to some folder if unknown
in

{
  # Other system configurations...

  environment.variables = {
    # Set the environment variable for Hyprland config directory
    HYPR_CONFIG_DIR = hyprConfigDir;
  };

  # Ensure that Hyprland starts with the correct configuration
  # You can add a hook to reload Hyprland with the appropriate config
  systemd.user.services.hyprland = {
    description = "Hyprland";
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.hyprland}/bin/hyprland --config ${hyprConfigDir}/hyprland.conf";
  };
}
