{
  description = "Flake for super-productivity development environment using Node.js and Angular CLI";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
    # importNpmLock is assumed to be available in your nixpkgs; if not, you may need to adjust accordingly.
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        # Dev shells: using "devShells" instead of "shells" helps when using `nix develop`
        devShells = with pkgs; {
          default = mkShell {
            buildInputs = [
              # Using a Node.js version that satisfies Node >=14 requirements.
              nodejs
              # This hook links node_modules if you use npm lock files.
              importNpmLock.hooks.linkNodeModulesHook
            ];

            # Build the node_modules using the lock file from the project root.
            npmDeps = importNpmLock.buildNodeModules {
              npmRoot = ./.;
              inherit nodejs;
            };

            shellHook = ''
              echo "super-productivity development environment is ready."
              # Check if Angular CLI is installed; if not, install it globally.
              if ! command -v ng > /dev/null; then
                echo "Angular CLI not found. Installing @angular/cli globally..."
                npm install -g @angular/cli
              fi
              echo -e "\e[1;32mTo start the dev server, run: ng serve\e[0m"
            '';
          };
        };

        # Optional: A package definition if you want to build a deployable package.
        packages = with pkgs; {
          default = buildNpmPackage {
            pname = "super-productivity";
            version = "11.1.3";
            src = ./.;

            npmDeps = importNpmLock {
              npmRoot = ./.;
            };

            npmConfigHook = importNpmLock.npmConfigHook;
          };
        };
      }
    );
}
