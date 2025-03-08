return {
  "snacks.nvim",
  opts = {
    indent = { enabled = true },
    scope = {
      enabled = true, -- enable highlighting the current scope
      priority = 200,
      char = "│",
      underline = false, -- underline the start of the scope
      only_current = false, -- only show scope in the current window
      hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
    },
  },
}
