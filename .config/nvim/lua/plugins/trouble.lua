return {
  "folke/trouble.nvim",
  -- opts will be merged with the parent spec
  opts = {
    icons = {
      indent = {
        middle = " ",
        last = " ",
        top = " ",
        ws = "│  ",
      },
    },
    modes = {
      diagnostics = {
        groups = {
          { "filename", format = "{file_icon} {basename:Title} {count}" },
        },
      },
    },
  },
}
