-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Buffer switch
--map("n", "<tab>", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bN", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })

map("n", "<leader>bq", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Neotree
map("n", "<leader>rr", ":Neotree focus<CR>", { desc = "NeoTree reveal", silent = true })

-- Obsidian.nvim
map("n", "<leader>fo", ":ObsidianQuickSwitch<CR>", { desc = "Obsidian File Search", silent = true })
map("n", "<leader>fO", ":ObsidianSearch<CR>", { desc = "Obsidian Search in Files", silent = true })

-- Edgy.nvim NeoTree outline, buffer, git status
map("n", "<leader>rb", ":Neotree buffers<CR>", { desc = "NeoTree reveal", silent = true })
map("n", "<leader>rg", ":Neotree git_status<CR>", { desc = "NeoTree reveal", silent = true })

-- Focus window keys
map("n", "<C-a>", "<cmd>wincmd h<CR>", { desc = "Focus left window", silent = true })
map("n", "<C-d>", "<cmd>wincmd l<CR>", { desc = "Focus right window", silent = true })

-- Copy all lines in buffer
map("n", "<C-c>", ":%y<CR>", { desc = "Copy all lines in buffer" })

-- Tab indetation, shift tab dedentation
map("v", "<Tab>", "<cmd>normal! > | gv<cr>", { desc = "Indent selected lines" })
map("v", "<S-Tab>", "<cmd>normal! < | gv<cr>", { desc = "Dedent selected lines" })

-- snacks live_grep on current directory
map("n", "<leader>fq", ":lua Snacks.dashboard.pick('live_grep')<CR>", { desc = "Snacks live_grep" })

-- It's already default:
--map("n", "<leader>bd", Snacks.bufdelete, { desc = "Delete Buffer" })
-- map('<leader>e', ':Neotree toggle<CR>',{desc = 'Neotree toggle'})
