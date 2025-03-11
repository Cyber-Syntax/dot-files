return {
  -- extras
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.git" },
  { import = "lazyvim.plugins.extras.lang.json" },
  -- { import = "lazyvim.plugins.extras.lang.nix" },
  { import = "lazyvim.plugins.extras.editor.outline" },
  -- use mini.starter instead of alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },
  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  -- harpoon
  { import = "lazyvim.plugins.extras.editor.harpoon2" },
  -- illuminate: highlight same words with underline
  { import = "lazyvim.plugins.extras.editor.illuminate" },
  -- copilot
  { import = "lazyvim.plugins.extras.ai.copilot" },
  --FIXME: blink not work at all
  -- { import = "lazyvim.plugins.extras.coding.blink" },

  -- add edgy.nvim for IDE like features
  -- BUG: open two window on the start
  --   { import = "lazyvim.plugins.extras.ui.edgy" },

  ----FIX: 'git' command not found on command section?
  -- {
  --  "tpope/vim-fugitive",
  --}

  -- -- disable trouble
  -- { "folke/trouble.nvim", enabled = false },
}
