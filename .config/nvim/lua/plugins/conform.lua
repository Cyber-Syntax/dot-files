return {
  "stevearc/conform.nvim",
  lazy = true,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      --nix = { "alejandra" },
      -- nix = { "nixfmt-rfc-style" },
      -- Conform will run multiple formatters sequentially
      python = { "ruff" },
      -- Conform will run the first available formatter
      javascript = { "prettierd", "prettier", stop_after_first = true },
      -- markdown
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
