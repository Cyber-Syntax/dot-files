{ pkgs, ... }:
#TODO: use it when kde not work on hyprland
{
  home.file.".config/hypr/auth.conf".text = ''
    exec-once = ${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1
    exec-once = ${pkgs.libsForQt5.kwallet-pam}/libexec/pam_kwallet_init
  '';
}
