-- add any tools you want to have installed below
-- TODO: marksman installed by default via mason. Probably default on lazyvim
return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "stylua",
      "shellcheck",
      "shfmt",
      "flake8",
      --"nixfmt", --BUG: not found on mason
      "markdownlint",
      "nixfmt-rfc-style",
      "prettierd",
    },
  },
}
