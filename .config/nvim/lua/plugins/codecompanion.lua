return {
  {
    "olimorris/codecompanion.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      {
        "stevearc/dressing.nvim",
        opts = {},
      },
      {
        "saghen/blink.cmp",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
          sources = {
            default = { "codecompanion" },
            providers = {
              codecompanion = {
                name = "CodeCompanion",
                module = "codecompanion.providers.completion.blink",
                enabled = true,
              },
            },
          },
        },
        opts_extend = {
          "sources.default",
        },
      },
    },
    opts = function(_, opts)
      local custom_opts = {
        adapters = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  default = "claude-3.7-sonnet",
                },
              },
            })
          end,
          -- chat = {
          --   adapter = "copilot",
          --   model = {
          --     default = "claude-3.7-sonnet",
          --   },
          -- },
          -- inline = {
          --   adapter = "copilot",
          --   model = {
          --     default = "claude-3.7-sonnet",
          --   },
          -- },
          -- cmd = {
          --   adapter = "copilot",
          --   model = {
          --     default = "claude-3.7-sonnet",
          --   },
          -- },
          -- anthropic = anthropic_fn,
          -- openai = openai_fn,
          -- gemini = gemini_fn,
          -- ollama = ollama_fn,
        },
      }

      return vim.tbl_deep_extend("force", opts, custom_opts)
    end,

    config = function(_, opts)
      require("codecompanion").setup(opts)
    end,
    -- keys = require("fredrik.config.keymaps").setup_codecompanion_keymaps(),
  },
}
