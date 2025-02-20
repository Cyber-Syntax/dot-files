{ ... }:
{
  imports = [
    ./firefox
    ./gtk
    ./zsh
    # ./hyprland.nix

    #TEST: send to nixos instead of home-manager
    #    ./xdg # portal #BUG: -gtk not preset, not start auto
  ];
}
