{ ... }:

{

  imports = [
    ./dashboard.nix
    ./debugging.nix
    #./default.nix #TESTING:
    ./find.nix
    ./keys.nix
    ./language.nix
    ./options.nix
    ./extra.nix
    ./plugins.nix
    ./python/language.nix
    #./python/default.nix
    ./python/debugging.nix
    ./javascript/debugging.nix
    ./javascript/language.nix
    # nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

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
