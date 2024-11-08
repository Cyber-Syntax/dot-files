{
#TEST: Lets stick with unstable for now, maybe we would get stay on 24.11 after it released
#NOTE: If something goes wrong, we can pin old version and update others
  inputs = {
      # nixpkgs = {
      #   url = "github:NixOS/nixpkgs/nixos-24.05";
      # };
      nixpkgs = {
        url = "github:NixOS/nixpkgs/nixos-unstable";
      };
      nixos-hardware = {
        url = "github:NixOS/nixos-hardware/master";
      };
      home-manager = {
        url = "github:nix-community/home-manager";
        #url = "github:nix-community/home-manager/release-24.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      firefox-addons = {
        url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      #TODO: Learn secrets management later
      # sops-nix = {
      #   url = "github:Mic92/sops-nix";
      #   inputs.nixpkgs.follows = "nixpkgs";
      # };  
  };

#TODO: Clear indentinations
#add sops-nix later here
  outputs = { 
  nixpkgs, 
  #nixpkgs-unstable, 
  nixos-hardware, home-manager, firefox-addons, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      #nixos-hardware = inputs.nixos-hardware.nixosModules;
      home-manager = inputs.home-manager.nixosModules.home-manager;
      #sops-nix = inputs.sops-nix.nixosModules.sops;
      createSystem =
        {
          name,
          config,
          #base,
          home,        
          #system,
          #extraModules,
        }:
        let
          #TODO: change this version after you change stateVersion
          version = "24.05";
          specialArgs = {
            # unstable = import nixpkgs-unstable { 
            #   inherit system;
            #   config.allowUnfree = true;
            # };

            inherit
              inputs
              system
              version
              name
              ;
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            #base
            #system
            config
            home-manager
            #sops-nix
            {
              imports = [ 
              #./cachix.nix 
              ];
              home-manager = {
                backupFileExtension = "bak22";
                extraSpecialArgs = specialArgs;
                users.${name} = {
                  imports = [ home ];
                  home.stateVersion = version;
                };
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }
          #] ++ extraModules;
          ];
        };
    in
    {
      # Set default formatter for `nix fmt`
      formatter.${system} = pkgs.nixfmt-rfc-style;
      # Declare system configurations
      nixosConfigurations = {
        "nixos" = createSystem {
          name = "developer";
          config = ./hosts/desktop/configuration.nix;
          home = ./hosts/desktop/home.nix;
          #extraModules = [ nixos-hardware.common-cpu-amd ];
        };
        "laptop" = createSystem {
          name = "developer";
          config = ./hosts/laptop/configuration.nix;
          home = ./hosts/laptop/home.nix;
          #system = ./hosts/laptop/system.nix;
          #extraModules = [nixos-hardware.common-cpu-intel nixos-hardware.common-pc-laptop];
        };
      };
    };
}
