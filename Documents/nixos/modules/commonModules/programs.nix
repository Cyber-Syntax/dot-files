{ pkgs, ...}:

{
  environment.pathsToLink = ["/share/zsh"];
  environment.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

  environment.variables.EDITOR = "nvim";

  programs = {
    dconf.enable = true;
    
    #TODO: tutanota-desktop fix needed
    seahorse = {
      enable = true;
    };
  };
}
