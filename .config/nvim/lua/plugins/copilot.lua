return {
  "zbirenbaum/copilot.lua",
  -- lazy = true,
  -- event = "InsertEnter",
  -- enabled = true,
  opts = {
    suggestion = {
      enabled = not vim.g.ai_cmp,
      auto_trigger = true,
      hide_during_completion = vim.g.ai_cmp,
      debounce = 75, -- Seems like latency for suggestions
      keymap = {
        accept = false, -- handled by nvim-cmp / blink.cmp
        next = "<M-]>",
        prev = "<M-[>",
      },
    },
    panel = { enabled = false, auto_refresh = true },
    copilot_model = "gpt-4o-copilot", -- Current LSP default is gpt-35-turbo, supports gpt-4o-copilot
    filetypes = {
      yaml = false,
      markdown = false,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      ["."] = false,
    },
    workspace_folders = {
      "/home/developer/Documents/repository/",
    },
  },
  -- add ai_accept action
  {
    "zbirenbaum/copilot.lua",
    opts = function()
      LazyVim.cmp.actions.ai_accept = function()
        if require("copilot.suggestion").is_visible() then
          LazyVim.create_undo()
          require("copilot.suggestion").accept()
          return true
        end
      end
    end,
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(
        opts.sections.lualine_x,
        2,
        LazyVim.lualine.status(LazyVim.config.icons.kinds.Copilot, function()
          local clients = package.loaded["copilot"] and LazyVim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}
          if #clients > 0 then
            --HACK: Workaround fixes for current lazyvim error for copiloy lualine
            -- It was returning nil value for status on lualine
            local api_status = require("copilot.api").status
            if api_status and api_status.data and api_status.data.status then
              local status = api_status.data.status
              return (status == "InProgress" and "pending") or (status == "Warning" and "error") or "ok"
            end
            return "ok"
          end
        end)
      )
    end,
  },

  vim.g.ai_cmp and {
    {
      "saghen/blink.cmp",
      optional = true,
      dependencies = { "giuxtaposition/blink-cmp-copilot" },
      opts = {
        sources = {
          default = { "copilot" },
          providers = {
            copilot = {
              name = "copilot",
              module = "blink-cmp-copilot",
              kind = "Copilot",
              score_offset = 100,
              async = true,
            },
          },
        },
      },
    },
  } or nil,
}
