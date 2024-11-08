{ pkgs, ...}:

{
  environment.pathsToLink = ["/share/zsh"];
  environment.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

  environment.variables.EDITOR = "nvim";

  programs = {
    dconf.enable = true;
    # non-nix executables like lua-language-server etc.
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
        lua-language-server
        luarocks # for lua
        stylua # lua formatter
    ];
    
    #TODO: tutanota-desktop fix needed
    seahorse = {
      enable = true;
    };
  };
}
