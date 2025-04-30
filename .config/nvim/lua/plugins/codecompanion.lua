return {
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function(_, opts)
      local custom_opts = {
        adapters = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  order = 1,
                  mapping = "parameters",
                  type = "enum",
                  desc = "ID of the model to use. See the model endpoint compatibility table for details on which models work with the Chat API.",
                  ---@type string|fun(): string
                  default = "claude-3.7-sonnet",
                  choices = {
                    "claude-3.5-sonnet",
                    "claude-3.7-sonnet",
                    "gpt-4o-2024-08-06",
                  },
                },
              },
            })
          end,
        },
      }
      return vim.tbl_deep_extend("force", opts, custom_opts)
    end,

    config = function(_, opts)
      require("codecompanion").setup(opts)
    end,
  },

  -- {
  --   "olimorris/codecompanion.nvim",
  --   -- lazy = true,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     -- "nvim-telescope/telescope.nvim",
  --     {
  --       "stevearc/dressing.nvim",
  --       opts = {},
  --     },
  --     {
  --       "saghen/blink.cmp",
  --       ---@module 'blink.cmp'
  --       ---@type blink.cmp.Config
  --       opts = {
  --         sources = {
  --           default = { "codecompanion" },
  --           providers = {
  --             codecompanion = {
  --               name = "CodeCompanion",
  --               module = "codecompanion.providers.completion.blink",
  --               enabled = true,
  --             },
  --           },
  --         },
  --       },
  --       opts_extend = {
  --         "sources.default",
  --       },
  --     },
  --   },
  --   opts = function(_, opts)
  --     local custom_opts = {
  --       adapters = {
  --         copilot = function()
  --           return require("codecompanion.adapters").extend("copilot", {
  --             schema = {
  --               model = {
  --                 order = 1,
  --                 mapping = "parameters",
  --                 type = "enum",
  --                 desc = "ID of the model to use. See the model endpoint compatibility table for details on which models work with the Chat API.",
  --                 ---@type string|fun(): string
  --                 default = "claude-3.7-sonnet",
  --                 choices = {
  --                   ["o3-mini-2025-01-31"] = { opts = { can_reason = true } },
  --                   ["o1-2024-12-17"] = { opts = { can_reason = true } },
  --                   ["o1-mini-2024-09-12"] = { opts = { can_reason = true } },
  --                   "claude-3.5-sonnet",
  --                   "claude-3.7-sonnet",
  --                   "claude-3.7-sonnet-thought",
  --                   "gpt-4o-2024-08-06",
  --                   "gemini-2.0-flash-001",
  --                 },
  --               },
  --             },
  --           })
  --         end,
  --       },
  --     }
  --
  --     return vim.tbl_deep_extend("force", opts, custom_opts)
  --   end,
  --
  --   config = function(_, opts)
  --     require("codecompanion").setup(opts)
  --   end,
  --   -- keys = require("fredrik.config.keymaps").setup_codecompanion_keymaps(),
  -- },
}
