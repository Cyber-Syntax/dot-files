{pkgs, ...}:
# pkgs = import nixpkgs {
#   system = "x86_64-linux";
#   config = { allowUnfree = true;
#              allowUnfreePredicate = (_: true); };
# };
# pkgs-unstable = import nixpkgs-unstable {
#   system = "x86_64-linux";
#   config = {
#     allowUnfree = true;
#     allowUnfreePredicate = (_: true);
#   };
# };
{
  home-manager.users.developer.programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      # plugins from nixpkgs go in here.
      # https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=vimPlugins
      nvim-treesitter.withAllGrammars
      luasnip # snippets | https://github.com/l3mon4d3/luasnip/
      # nvim-cmp (autocompletion) and extensions
      nvim-cmp # https://github.com/hrsh7th/nvim-cmp
      cmp_luasnip # snippets autocompletion extension for nvim-cmp | https://github.com/saadparwaiz1/cmp_luasnip/
      lspkind-nvim # vscode-like LSP pictograms | https://github.com/onsails/lspkind.nvim/
      cmp-nvim-lsp # LSP as completion source | https://github.com/hrsh7th/cmp-nvim-lsp/
      cmp-nvim-lsp-signature-help # https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/
      cmp-buffer # current buffer as completion source | https://github.com/hrsh7th/cmp-buffer/
      cmp-path # file paths as completion source | https://github.com/hrsh7th/cmp-path/
      cmp-nvim-lua # neovim lua API as completion source | https://github.com/hrsh7th/cmp-nvim-lua/
      cmp-cmdline # cmp command line suggestions
      cmp-cmdline-history # cmp command line history suggestions
      # ^ nvim-cmp extensions
      # git integration plugins
      diffview-nvim # https://github.com/sindrets/diffview.nvim/
      neogit # https://github.com/TimUntersberger/neogit/
      gitsigns-nvim # https://github.com/lewis6991/gitsigns.nvim/
      vim-fugitive # https://github.com/tpope/vim-fugitive/
      # ^ git integration plugins
      # telescope and extensions
      telescope-nvim # https://github.com/nvim-telescope/telescope.nvim/
      telescope-fzy-native-nvim # https://github.com/nvim-telescope/telescope-fzy-native.nvim
      # telescope-smart-history-nvim # https://github.com/nvim-telescope/telescope-smart-history.nvim
      # ^ telescope and extensions
      # UI
      lualine-nvim # Status line | https://github.com/nvim-lualine/lualine.nvim/
      nvim-navic # Add LSP location to lualine | https://github.com/SmiteshP/nvim-navic
      statuscol-nvim # Status column | https://github.com/luukvbaal/statuscol.nvim/
      nvim-treesitter-context # nvim-treesitter-context
      # ^ UI
      # language support
      # ^ language support
      # navigation/editing enhancement plugins
      vim-unimpaired # predefined ] and [ navigation keymaps | https://github.com/tpope/vim-unimpaired/
      eyeliner-nvim # Highlights unique characters for f/F and t/T motions | https://github.com/jinh0/eyeliner.nvim
      nvim-surround # https://github.com/kylechui/nvim-surround/
      nvim-treesitter-textobjects # https://github.com/nvim-treesitter/nvim-treesitter-textobjects/
      nvim-ts-context-commentstring # https://github.com/joosepalviste/nvim-ts-context-commentstring/
      # ^ navigation/editing enhancement plugins
      # Useful utilities
      nvim-unception # Prevent nested neovim sessions | nvim-unception
      # ^ Useful utilities
      # libraries that other plugins depend on
      sqlite-lua
      plenary-nvim
      nvim-web-devicons
      vim-repeat
      # ^ libraries that other plugins depend on
      # bleeding-edge plugins from flake inputs
      # (mkNvimPlugin inputs.wf-nvim "wf.nvim") # (example) keymap hints | https://github.com/Cassin01/wf.nvim
      # ^ bleeding-edge plugins from flake inputs
      which-key-nvim

      # core if lazyvim not work
      # nvim-web-devicons
      # telescope-nvim
      # telescope-fzy-native-nvim
      # nvim-cmp
      # cmp-buffer
      # cmp-path
      cmp-zsh
      # cmp-nvim-lua
      # luasnip
      # cmp_luasnip
      nvim-lspconfig
      cmp-nvim-lsp

      #TESTING: these are give error on nixos
      neo-tree-nvim
      indent-blankline-nvim
      mini-pairs
      # nvim-treesitter

      # specifics # install if lua not work
      obsidian-nvim
      render-markdown-nvim
    ];

    extraConfig = ''
      :luafile ~/.config/nvim/lua/init.lua
    '';
  };

  home-manager.users.developer.home.packages = with pkgs; [
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
    # markdown-toc
    shfmt
  ];

  home-manager.users.developer.xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
