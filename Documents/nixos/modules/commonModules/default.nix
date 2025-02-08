{ ... }:
{
  imports = [
    ./appimages
    ./boot
    ./fonts
    ./i18n
    ./network
    ./nix
    ./nixvim
    ./packages
    ./packages-unstable
    ./programs
    ./security
    ./services
    ./xdg
    # ./qtile
    #TESTING:
    ./hyprland.nix
    #FIX: qtile extras not work
    # ./qtile-wayland
  ];
}
