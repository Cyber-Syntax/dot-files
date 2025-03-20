return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          win = {
            input = { keys = { ["<C-d>"] = false }, mode = { "n", "i" } },
            list = { keys = { ["<C-d>"] = false }, mode = { "n", "i" } },
          },
        },
      },
    },
  },
}
