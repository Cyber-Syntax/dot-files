{ pkgs, ... }:

{
  environment.pathsToLink = [ "/share/zsh" ];
  environment.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

  environment.variables.EDITOR = "nvim";

  programs = {
    dconf.enable = true;
    bash.completion.enable = true; # default:true

    ##TEST:
    # # non-nix executables like lua-language-server etc.
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      #lua
      lua-language-server
      luarocks # for lua
      stylua # lua formatter
      # markdown
      marksman
      vimPlugins.vim-markdown-toc
      markdownlint-cli2
      #python
      ruff
      pyright
      #nix
      nil
      nixfmt-rfc-style
      #bash, shell
      bash-language-server
      #json
      #json-lsp #FIX: find correct name
      #Other
      stdenv.cc.cc.lib
      zlib
      # html
      prettierd # TODO: need setup on neovim
    ];

    #TODO: tutanota-desktop fix needed
    seahorse = {
      enable = true;
    };
  };
}
