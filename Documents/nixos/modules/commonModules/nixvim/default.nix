{ ... }:
## Credits:
# Main setup from @fred-drake.
#https://github.com/fred-drake/neovim
# Me "Cyber-Syntax" make some changes to make it like LazyVim.

{
  imports = [
    ./dashboard.nix
    ./debugging.nix
    ./keys.nix
    ./language.nix
    ./options.nix
    ./extra.nix
    ./plugins.nix
    ./python/language.nix
    ./python/debugging.nix
    ./javascript/debugging.nix
    ./javascript/language.nix
  ];

  programs.nixvim = {
    enable = true;

    clipboard.register = "unnamedplus";
    clipboard.providers = {
      xclip.enable = true;
    };

    colorschemes = {
      nord = {
        enable = true;
        settings = {
          borders = true;
          disable_background = true;
          italic = true;
        };
      }; # ./nord
    }; # ./ccolorschemes
  };

}
