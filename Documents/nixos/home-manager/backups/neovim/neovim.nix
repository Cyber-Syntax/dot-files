{ pkgs, ... }:

{
  home-manager.users.developer.programs.neovim = {
    enable = true;
    defaultEditor = true;
    #extraPython3Packages = pyPkgs: with pyPkgs; [ python-language-server ];
    extraConfig = ''
      :luafile ~/.config/nvim/lua/init.lua
    '';

    extraPackages = with pkgs; [
      #Language server packages (executables)
        xclip
        ripgrep
        nixfmt-rfc-style
        nil
        lua
        lua-language-server
        stylua
        # json-lsp
        pyright
        # ruff
        bash-language-server
        shellcheck
        # flake8
        # markdownlint
        marksman
        markdownlint-cli2
        # markdownlint-cli
        # markdown-t    
    ];
    plugins = with pkgs.vimPlugins; [
      LazyVim
      render-markdown-nvim
      indent-blankline-nvim
      mini-pairs
      # ollama-nvim
      # lazy-nvim
      # nvim-treesitter
      # nvim-cmp
      # nvim-colorizer-lua
      # nvim-autopairs
      # nvim-lspconfig
      # nvim-tree-lua
      # nvim-web-devicons 
      # nvterm
      # plenary-nvim
      # telescope-nvim
      # which-key-nvim
      # mason-nvim
      # luasnip
      # gitsigns-nvim
      # friendly-snippets
      # conform-nvim
      # comment-nvim
      # cmp_luasnip
      # cmp-path
      # cmp-nvim-lua
      # cmp-nvim-lsp
      # cmp-buffer
      # better-escape-nvim
      # base46    
    ];

  };

  home-manager.users.developer.xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
