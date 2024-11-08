-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- Buffer switch
--map("n", "<tab>", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bd", LazyVim.ui.bufremove, { desc = "Delete Buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bN", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- Neotree
-- map('<leader>e', ':Neotree toggle<CR>',{desc = 'Neotree toggle'})
map("n", "<leader>rr", ":Neotree focus<CR>", { desc = "NeoTree reveal", silent = true })
