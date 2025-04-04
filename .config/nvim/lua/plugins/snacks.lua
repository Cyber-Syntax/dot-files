return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true,
          ignored = true,
          -- ignored = false,
          -- exclude = {
          --   ".git",
          --   "node_modules",
          --   ".gitignore",
          -- },
        },
        explorer = {
          -- Show hidden files
          hidden = true,
          ignored = true,
          -- exclude = {
          --   "test*",
          -- },
          -- This fixes the issue with alt+d not working
          win = {
            input = { keys = { ["<C-d>"] = false }, mode = { "n", "i" } },
            list = { keys = { ["<C-d>"] = false }, mode = { "n", "i" } },
          },
        },
      },
    },
  },
}
