{ ... }:
{
  nix = {
    daemonCPUSchedPolicy = "batch"; # medium=batch, default: high=other, low=idle
    daemonIOSchedClass = "idle"; # high=best-effort, low=idle
    daemonIOSchedPriority = 4; # default=4, 0 high, 7 low
    # add overlays-compat
    #nixPath = [ "/home/developer/Documents/nixos/overlays-compat/"];

    gc = {
      # To turn on periodic optimisation of the nix store:
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
      persistent = true; # Default = true. This make systemd timer persistent if missed the last start time, similar anacron
    };
    # TODO: Learn more detail
    extraOptions = ''
      min-free = ${toString (10 * 1024 * 1024 * 1024)}
      max-free = ${toString (15 * 1024 * 1024 * 1024)}
    '';

    # It is also possible to automatically run garbage collection whenever there is not enough space left.[cf. 5] For example, to free up to 1GiB whenever there is less than 100MiB left:
    # nix.extraOptions = ''
    #   min-free = ${toString (100 * 1024 * 1024)}
    #   max-free = ${toString (1024 * 1024 * 1024)}
    # '';

    settings = {
      warn-dirty = false;
      use-xdg-base-directories = true;
      builders-use-substitutes = true;
      max-substitution-jobs = 20;
      #Alternatively, the store can be optimised during every build. This may slow down builds, as discussed here. To enable this behavior, set the following option:
      # This already done by periodic optimisation, I don't need to do that on every build
      # auto-optimise-store = true;

      #TEST: enableParallelBuilding need to be enabled to used on packages??

      max-jobs = "auto"; # default: auto, total number of logical cores
      cores = 0; # default: 0, all cpu cores going to be used for builder

      allowed-users = [
        "developer"
        "@wheel"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      substituters = [
        "https://cache.nixos.org/"
        #"https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        #"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

    };
  };
}
