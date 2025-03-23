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

-- local persistence = require("persistence")
--
-- persistence.current = function(opts)
--   return vim.fn.getcwd() .. "/session.vim"
-- end
--
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     local session_file = persistence.current()
--     if vim.fn.filereadable(session_file) == 1 then
--       require("persistence").load()
--     end
--   end,
-- })

local persistence = require("persistence")

-- Override session path to current directory
persistence.current = function(opts)
  return vim.fn.getcwd() .. "/session.vim"
end

-- Setup with always-save mode
persistence.setup({
  options = {
    need = 0, -- Always save regardless of buffer count
  },
})

-- Load session on enter if exists
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local session_file = persistence.current()
    if vim.fn.filereadable(session_file) == 1 then
      persistence.load()
    end
    -- Initial save after load
    persistence.save()
  end,
})

-- Save on buffer/window changes (with debouncing)
local save_debounce = nil
local function debounced_save()
  if save_debounce then
    save_debounce:close()
  end
  save_debounce = vim.loop.new_timer()
  save_debounce:start(
    2000,
    0,
    vim.schedule_wrap(function()
      persistence.save()
      save_debounce:close()
      save_debounce = nil
    end)
  )
end

-- Track important events
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "WinEnter" }, {
  callback = debounced_save,
})

-- Safety save every 5 minutes
vim.loop.new_timer():start(0, 5 * 60 * 1000, vim.schedule_wrap(persistence.save))

-- Optional: Save when leaving Neovim (already handled by plugin)

--TESTING:
-- -- Create an autocommand group to manage related autocommands
-- local group = vim.api.nvim_create_augroup("ProjectSession", { clear = true })
--
-- -- Define the autocommand
-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   group = group,
--   pattern = "*",
--   callback = function()
--     -- Construct the session file path within the current working directory
--     local session_file = vim.fn.getcwd() .. "/session.vim"
--     -- Save the current session to the specified file
--     vim.cmd("mks! " .. vim.fn.fnameescape(session_file))
--   end,
-- })
-- -- Create an autocommand group for session loading
-- local group = vim.api.nvim_create_augroup("LoadProjectSession", { clear = true })
--
-- -- Define the autocommand
-- vim.api.nvim_create_autocmd("VimEnter", {
--   group = group,
--   pattern = "*",
--   callback = function()
--     -- Construct the session file path within the current working directory
--     local session_file = vim.fn.getcwd() .. "/session.vim"
--     -- Check if the session file exists and is readable
--     if vim.fn.filereadable(session_file) == 1 then
--       -- Source the session file to restore the session
--       vim.cmd("source " .. vim.fn.fnameescape(session_file))
--     end
--   end,
-- })

--NOTE: not save on the enter etc.
-- Create an autocmd that writes a session file (session.vim) in the current working directory
-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   pattern = "*",
--   callback = function()
--     -- Construct the path for the session file in the current project directory
--     local session_file = vim.fn.getcwd() .. "/session.vim"
--     -- Open the file for writing (overwriting any existing file)
--     local file, err = io.open(session_file, "w")
--     if not file then
--       vim.notify("Error writing session file: " .. err, vim.log.levels.ERROR)
--       return
--     end
--     -- Write a single line that calls persistence.nvim's load function.
--     -- This wrapper will, when sourced, execute the load and restore your session.
--     file:write("lua require('persistence').load()")
--     file:close()
--     vim.notify("Session file written to " .. session_file)
--   end,
-- })
