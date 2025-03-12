return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "BufReadPost",
  opts = {
    suggestion = {
      -- enabled = not vim.g.ai_cmp,
      enabled = true,
      auto_trigger = true,
      -- hide_during_completion = vim.g.ai_cmp,
      keymap = {
        -- accept = false, -- handled by nvim-cmp / blink.cmp
        accept = "<Tab>",
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
}
