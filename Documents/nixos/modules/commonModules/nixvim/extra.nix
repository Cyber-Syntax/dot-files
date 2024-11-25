{pkgs, nixvim, ...}: {
  programs.nixvim.extraPlugins = with pkgs; [
    # vimPlugins.supermaven-nvim # AI code completion
    # vimPlugins.vim-dadbod # DB client
    # vimPlugins.vim-dadbod-completion # DB completion
    # vimPlugins.vim-dadbod-ui # DB UI
  ];

  programs.nixvim.extraConfigLua = ''
    require("telescope").load_extension('harpoon')

    require("notify").setup({
      background_colour = "#000000",
    })
  '';
}
