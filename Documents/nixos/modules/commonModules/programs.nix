{ pkgs, ...}:

{
  ### ZSH
  environment.pathsToLink = ["/share/zsh"];
  environment.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

  # global default editor neovim
  environment.variables.EDITOR = "nvim";

  programs = {
    dconf.enable = true;
    
    #TODO: tutanota-desktop fix needed
    seahorse = {
      enable = true;
    };
  };

}
