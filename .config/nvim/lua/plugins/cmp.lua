return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
    "hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
    "tadmccorkle/markdown.nvim", -- Markdown support
  },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    table.insert(opts.sources, { name = "emoji" })
  end,
  -- opts = {
  --   completion = {
  --     completeopt = "menu,menuone,noselect,noinsert",
  --   },
  --   experimental = {
  --     ghost_text = false, -- Disable ghost text feature
  --   },
  -- },
}
