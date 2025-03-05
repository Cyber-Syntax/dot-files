{...}: {
  imports = [
    ./hardware-configuration.nix

    ./../../modules/commonModules/default.nix
    ./../../home-manager/default.nix
    ./../../overlays/default.nix
    ./../../modules/desktopModules/default.nix
    # Specific versions from github.
    # ./../../derivations/default.nix
  ];

  #TODO: is this work?
  ### Windows dualboot time date problem solve:
  #time.hardwareClockInLocalTime = true; # Didn't solve superProductivity date/time issue

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
