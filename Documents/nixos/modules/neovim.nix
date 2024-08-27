
{config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    # extraConfig = ''
    #   let g:python3_host_prog = "${pkgs.python3}/bin/python"
    #   let g:python_host_prog = "${pkgs.python2}/bin/python"
    # '';
      };
}


