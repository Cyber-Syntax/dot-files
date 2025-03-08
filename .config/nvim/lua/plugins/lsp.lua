-- add pyright to lspconfig
return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      -- pyright will be automatically installed with mason and loaded with lspconfig
      pyright = {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFileOnly",
              typeCheckingMode = "basic",
            },
          },
        },
      },
      marksman = { mason = false },
      bashls = {},
    },
    diagnostics = {
      virtual_text = false,
      update_in_insert = false,
    },
    inlay_hints = {
      enabled = false,
      -- exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
    },
  },
}
