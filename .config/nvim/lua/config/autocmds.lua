-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

-- Save session for the current project via persistence.nvim
-- autocmd VimLeave * execute
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "",
  command = ":%s/\\s\\+$//e",
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r fo-=o",
})

--TESTING:

-- persistence_snacks.lua

local persistence = require("persistence")

-- 1) pre_save: drop any buffers whose files live outside cwd
local function pre_save()
  local cwd = vim.fn.getcwd() .. "/"
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf)
    if name ~= "" and not name:match("^" .. vim.pesc(cwd)) then
      -- force‑delete so we don’t get “modified buffer” errors
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

-- 2) close any open Snacks explorer windows
local group = vim.api.nvim_create_augroup("user-persistence", { clear = true })
vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "PersistenceSavePre",
  callback = function()
    vim.cmd(":lua Snacks.explorer()")
  end,
})

-- 4) Disable persistence when writing Git commit messages
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    persistence.stop()
  end,
})

-- 5) Configure persistence.nvim (leave load() where it was)
persistence.setup({
  pre_save = pre_save,
  silent = true,
  options = { "buffers", "curdir", "tabpages", "winsize" },
})

-- -- 6) Restore session immediately (same as before)
-- persistence.load()

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("Persistence", { clear = true }),
  callback = function()
    persistence.load()
  end,
  -- HACK: need to enable `nested` otherwise the current buffer will not have a filetype(no syntax)
  nested = true,
})
