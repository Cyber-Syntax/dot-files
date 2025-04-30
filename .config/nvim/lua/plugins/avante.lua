return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = "copilot",
      auto_suggestions_provider = "copilot",
      behaviour = {
        enable_cursor_planning_mode = true, -- enable cursor planning mode!
      },
      copilot = {
        endpoint = "https://api.githubcopilot.com",
        model = "claude-3.7-sonnet",
        proxy = nil, -- [protocol://]host[:port] Use this proxy
        allow_insecure = false, -- Allow insecure server connections
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 90480,
        max_completion_tokens = 1000000,
        reasoning_effort = "high",
      },
      hints = { enabled = false },
      file_selector = {
        provider = "snacks",
        provider_opts = {},
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      -- {
      --   -- support for image pasting
      --   "HakonHarnes/img-clip.nvim",
      --   event = "VeryLazy",
      --   opts = {
      --     -- recommended settings
      --     default = {
      --       embed_image_as_base64 = false,
      --       prompt_for_file_name = false,
      --       drag_and_drop = {
      --         insert_mode = true,
      --       },
      --       -- required for Windows users
      --       use_absolute_path = true,
      --     },
      --   },
      -- },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
      {
        "folke/which-key.nvim",
        opts = {
          spec = {
            { "<leader>a", group = "ai" },
          },
        },
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    lazy = true,
    opts = {
      input = { enabled = false },
      select = { enabled = false },
    },
  },

  {
    "saghen/blink.compat",
    lazy = true,
    opts = {},
    config = function()
      -- monkeypatch cmp.ConfirmBehavior for Avante
      require("cmp").ConfirmBehavior = {
        Insert = "insert",
        Replace = "replace",
      }
    end,
  },
  {
    "saghen/blink.cmp",
    lazy = true,
    opts = {
      sources = {
        default = { "avante_commands", "avante_mentions", "avante_files" },
        providers = {
          avante_commands = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 90, -- show at a higher priority than lsp
            opts = {},
          },
          avante_files = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 100, -- show at a higher priority than lsp
            opts = {},
          },
          avante_mentions = {
            name = "avante_mentions",
            module = "blink.compat.source",
            score_offset = 1000, -- show at a higher priority than lsp
            opts = {},
          },
        },
      },
    },
  },
}

-- return {
--   {
--     "yetone/avante.nvim",
--     event = "VeryLazy",
--     dependencies = {
--       "nvim-treesitter/nvim-treesitter",
--       "stevearc/dressing.nvim",
--       "nvim-lua/plenary.nvim",
--       "MunifTanjim/nui.nvim",
--       --- The below dependencies are optional,
--       -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
--       "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
--       -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
--       "ibhagwan/fzf-lua", -- for file_selector provider fzf
--       -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
--       "zbirenbaum/copilot.lua", -- for providers='copilot'
--     },
--     opts = {
--       -- Default configuration
--       hints = { enabled = false },
--
--       ---@alias AvanteProvider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
--       provider = "copilot", -- Recommend using Claude
--       auto_suggestions_provider = "copilot",
--       -- Since auto-suggestions are a high-frequency operation and therefore expensive,
--       -- it is recommended to specify an inexpensive provider or even a free provider: copilot
--       -- claude = {
--       --   endpoint = "https://api.anthropic.com",
--       --   model = "claude-3-5-sonnet-20241022",
--       --   temperature = 0,
--       --   max_tokens = 4096,
--       -- },
--       -- behaviour = {
--       --   enable_cursor_planning_mode = true, -- enable cursor planning mode!
--       -- },
--       copilot = {
--         endpoint = "https://api.githubcopilot.com",
--         model = "claude-3.7-sonnet",
--         proxy = nil, -- [protocol://]host[:port] Use this proxy
--         allow_insecure = false, -- Allow insecure server connections
--         timeout = 30000, -- Timeout in milliseconds
--         temperature = 0,
--         max_tokens = 20480,
--         max_completion_tokens = 1000000,
--         reasoning_effort = "high",
--       },
--
--       -- File selector configuration
--       --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "snacks" | "telescope" | string
--       file_selector = {
--         provider = "telescope", -- Avoid native provider issues
--         provider_opts = {},
--       },
--     },
--     build = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
--   },
--   {
--     "saghen/blink.cmp",
--     lazy = true,
--     dependencies = { "saghen/blink.compat" },
--     opts = {
--       sources = {
--         default = { "avante_commands", "avante_mentions", "avante_files" },
--         compat = {
--           "avante_commands",
--           "avante_mentions",
--           "avante_files",
--         },
--         -- LSP score_offset is typically 60
--         providers = {
--           avante_commands = {
--             name = "avante_commands",
--             module = "blink.compat.source",
--             score_offset = 90,
--             opts = {},
--           },
--           avante_files = {
--             name = "avante_files",
--             module = "blink.compat.source",
--             score_offset = 100,
--             opts = {},
--           },
--           avante_mentions = {
--             name = "avante_mentions",
--             module = "blink.compat.source",
--             score_offset = 1000,
--             opts = {},
--           },
--         },
--       },
--     },
--   },
--   {
--     "stevearc/dressing.nvim",
--     lazy = true,
--     opts = {
--       input = { enabled = false },
--       select = { enabled = false },
--     },
--   },
--   {
--     "saghen/blink.compat",
--     lazy = true,
--     opts = {},
--     config = function()
--       -- monkeypatch cmp.ConfirmBehavior for Avante
--       require("cmp").ConfirmBehavior = {
--         Insert = "insert",
--         Replace = "replace",
--       }
--     end,
--   },
--   {
--     "MeanderingProgrammer/render-markdown.nvim",
--     optional = true,
--     ft = function(_, ft)
--       vim.list_extend(ft, { "Avante" })
--     end,
--     opts = function(_, opts)
--       opts.file_types = vim.list_extend(opts.file_types or {}, { "Avante" })
--     end,
--   },
--   {
--     "folke/which-key.nvim",
--     optional = true,
--     opts = {
--       spec = {
--         { "<leader>a", group = "ai" },
--       },
--     },
--   },
-- }
