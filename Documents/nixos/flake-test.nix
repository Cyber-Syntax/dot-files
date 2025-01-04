{
  inputs = {
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      home-manager,
      firefox-addons,
      nixvim,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      home-manager = inputs.home-manager.nixosModules.home-manager;
      nixvim = inputs.nixvim.nixosModules.nixvim;
      createSystem =
        {
          name,
          config,
          home,
          extraModules ? [ ],
        }:
        let
          version = "24.05";
          specialArgs = {
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
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
            config
            home-manager
            nixvim
            {
              # imports = [ ./cachix.nix ];
              home-manager = {
                backupFileExtension = "bak0";
                extraSpecialArgs = specialArgs;
                users.${name} = {
                  imports = [ home ];
                  home.stateVersion = version;
                };
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }
          ] ++ extraModules;
        };
    in
    {
      formatter.${system} = pkgs.nixfmt-rfc-style;
      nixosConfigurations = {
        "nixos" = createSystem {
          name = "developer";
          config = ./hosts/desktop/configuration.nix;
          home = ./hosts/desktop/home.nix;
          extraModules = [
            nixos-hardware.common-cpu-amd
            nixos-hardware.common-ssd
          ];
        };
        "laptop" = createSystem {
          name = "developer";
          config = ./hosts/laptop/configuration.nix;
          home = ./hosts/laptop/home.nix;
          extraModules = [
            nixos-hardware.common-cpu-intel
            nixos-hardware.common-pc-laptop
            nixos-hardware.common-ssd
          ];
        };
      };
    };
}
