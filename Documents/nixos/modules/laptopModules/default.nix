{ ... }:
{
  imports = [
    ./intel
    ./packages
    ./bluetooth
    ./thinkfan
    ./touchpad
    # ./tlp
    #TESTING: auto-cpufreq
    ./battery
    ./hyprland-laptop.nix
  ];
}
