return {
  --   -- your additional plugins
  --   --TODO: is copilot-vim much faster than copilot.lua?
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   event = "BufReadPost",
  --   opts = {
  --     suggestion = {
  --       enabled = not vim.g.ai_cmp,
  --       auto_trigger = true,
  --       hide_during_completion = vim.g.ai_cmp,
  --       keymap = {
  --         -- accept = false, -- handled by nvim-cmp / blink.cmp
  --         accept = "<Tab>",
  --         next = "<M-]>",
  --         prev = "<M-[>",
  --       },
  --     },
  --     panel = { enabled = false },
  --     -- filetypes = {
  --     --   markdown = true,
  --     --   help = true,
  --     -- },
  --   },
  --   specs = {
  --     {
  --       "hrsh7th/nvim-cmp",
  --       optional = true,
  --       ---@param opts cmp.ConfigSchema
  --       opts = function(_, opts)
  --         table.insert(opts.sources, 1, {
  --           name = "copilot",
  --           group_index = 1,
  --           priority = 100,
  --         })
  --       end,
  --     },
  --   },
  --   opts = function()
  --     LazyVim.cmp.actions.ai_accept = function()
  --       if require("copilot.suggestion").is_visible() then
  --         LazyVim.create_undo()
  --         require("copilot.suggestion").accept()
  --         return true
  --       end
  --     end
  --   end,
  -- },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        -- enabled = not vim.g.ai_cmp,
        enabled = false,
        auto_trigger = true,
        -- hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = false, -- handled by nvim-cmp / blink.cmp
          -- accept = "<Tab>",
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      -- filetypes = {
      --   markdown = true,
      --   help = true,
      -- },
    },
  },
}
