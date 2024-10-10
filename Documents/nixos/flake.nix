{
  inputs = {
      nixpkgs = {
        url = "github:NixOS/nixpkgs/nixos-unstable";
      };
      nixos-hardware = {
        url = "github:NixOS/nixos-hardware/master";
      };
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    
    # Third party programs, packaged with nix
#TESTING:
    ## nur for firefox extensions usage on home-manager
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
  

  outputs =
    {
      nixpkgs,
      nixos-hardware,
      home-manager,
      firefox-addons,
      #sops-nix, # secret management
      ...
    }@inputs:
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
                backupFileExtension = "bak10";
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
          #base = ../../etc/nixos/hosts/developer/base.nix;
          home = ./hosts/desktop/home.nix;
          #system = ../../etc/nixos/hosts/developer/system.nix;
          #extraModules = [ nixos-hardware.common-cpu-amd ];
        };
        "laptop" = createSystem {
          name = "developer";
          config = ./hosts/laptop/configuration.nix;
          #base = ./hosts/laptop/base.nix;
          home = ./hosts/laptop/home.nix;
          #system = ./hosts/laptop/system.nix;
          #extraModules = [nixos-hardware.common-cpu-intel nixos-hardware.common-pc-laptop];
        };
      };
    };
}
