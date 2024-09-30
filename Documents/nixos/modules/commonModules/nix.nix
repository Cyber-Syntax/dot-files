{ ... }:
{
  nix = {
    daemonCPUSchedPolicy = "batch"; #medium=batch, default: high=other, low=idle
    daemonIOSchedClass = "idle"; #high=best-effort, low=idle
    daemonIOSchedPriority = 4; #default=4, 0 high, 7 low
      # add overlays-compat
      #nixPath = [ "/home/developer/Documents/nixos/overlays-compat/"];

      gc = { # nixos garbage collection
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
        persistent = true; # Default = true. This make systemd timer persistent if missed the last start time, similar anacron
      };
    
      settings = {
        warn-dirty = false;
        use-xdg-base-directories = true;
        builders-use-substitutes = true;
        max-substitution-jobs = 20;
        auto-optimise-store = true;
        
        #TEST: enableParallelBuilding need to be enabled to used on packages??

        max-jobs = "auto"; # default: auto, total number of logical cores
        cores = 0; # default: 0, all cpu cores going to be used for builder 

        
        allowed-users = [ "developer" "@wheel"];
        experimental-features = ["nix-command" "flakes"];

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
