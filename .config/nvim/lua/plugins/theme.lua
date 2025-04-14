return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nordic",
    },
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").load()
    end,
  },
  -- {
  --   "gbprod/nord.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("nord").setup({})
  --     vim.cmd.colorscheme("nord")
  --   end,
  -- },
  -- { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
  -- {
  --   "projekt0n/github-nvim-theme",
  --   name = "github-theme",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require("github-theme").setup({
  --       -- ...
  --     })
  --
  --     vim.cmd("colorscheme github_dark")
  --   end,
  -- },
}
