{ config, pkgs, lib,... }:

{
  # TODO: Cause error: can't source chadrc.lua -> probably nvchad
  home-manager.users.developer.programs.neovim = {
    enable = true;
    defaultEditor = true;
    #extraPython3Packages = pyPkgs: with pyPkgs; [ python-language-server ];
    #extraConfig = lib.fileContents ../../../.config/nvim/init.lua;
    extraPackages = with pkgs; [
      #Language server packages (executables)
      pyright # python language server
      lua-language-server # lua
      nixd # nix
      #nil # nix 
    ]
    plugins = with pkgs.vimPlugins; [
      nvchad-ui
      nvchad
      ollama-nvim
      lazy-nvim
      nvim-treesitter
      nvim-cmp
      nvim-colorizer-lua
      nvim-autopairs
      nvim-lspconfig
      nvim-tree-lua
      nvim-web-devicons 
      nvterm
      plenary-nvim
      telescope-nvim
      which-key-nvim
      mason-nvim
      luasnip
      indent-blankline-nvim
      gitsigns-nvim
      friendly-snippets
      conform-nvim
      comment-nvim
      cmp_luasnip
      cmp-path
      cmp-nvim-lua
      cmp-nvim-lsp
      cmp-buffer
      better-escape-nvim
      base46    
    ];

  };

}
