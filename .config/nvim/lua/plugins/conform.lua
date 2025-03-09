return {
  "stevearc/conform.nvim",
  lazy = true,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
      ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
      html = { "prettierd" },
    },
  },

  -- event = 'BufWritePre', -- uncomment for format on save
  --opts = require "configs.conform",
  requires = {
    -- ""
  },
  keys = {
    {
      "<MS-f>",
      function()
        require("conform").format({ lsp_fallback = true })
      end,
      desc = "Format Buffer",
    },
  },
}
