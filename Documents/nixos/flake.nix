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
  
};
  

  outputs =
    {
      nixpkgs,
      nixos-hardware,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      nixos-hardware = inputs.nixos-hardware.nixosModules;
      home-manager = inputs.home-manager.nixosModules.home-manager;
      createSystem =
        {
          name,
          config,
          #base,
          home, #         
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

            {
              imports = [ 
              ./cachix.nix  
              ];
              home-manager = {
                backupFileExtension = "bak3";
                extraSpecialArgs = specialArgs;
                users.${name} = {
                  imports = [ 
                  home
                  ];
                  home.stateVersion = version;
                };
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }
          ]; #++ extraModules;
        };
    in
    {
      # Set default formatter for `nix fmt`
      formatter.${system} = pkgs.nixfmt-rfc-style;
      # Declare system configurations
      nixosConfigurations = {
        "nixos" = createSystem {
          name = "developer";
          config = ./configuration.nix;
          #base = ../../etc/nixos/hosts/developer/base.nix;
          home = ./hosts/developer/home.nix;
          #system = ../../etc/nixos/hosts/developer/system.nix;
          #extraModules = [ ];
        };
        "laptop" = createSystem {
          name = "cyber-syntax";
          config = ./hosts/cyber-syntax/configuration.nix;
          #base = ./hosts/cyber-syntax/base.nix;
          home = ./hosts/cyber-syntax/home.nix;
          #system = ./hosts/cyber-syntax/system.nix;
          #extraModules = [ nixos-hardware.thinkpad-e14-intel ];
        };
      };
    };
}
