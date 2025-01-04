return {
  "arakkkkk/kanban.nvim",
  -- Optional
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("kanban").setup({
      markdown = {
        -- Path to save the file corresponding to the task.
        --description_folder = "/home/developer/Documents/obsidian/main-vault/10_Dashboard/10.03_TODOS/",
        -- list_head = "## ",
        -- due_head = "@",
        -- due_style = "{<due>}",
        -- tag_head = "#",
        -- tag_style = "<tag>",
        -- header = {
        --   "---",
        --   "",
        --   "kanban-plugin: basic",
        --   "",
        --   "---",
        --   "",
        -- },
        -- footer = {
        --   "",
        --   "",
        --   "%% kanban:settings",
        --   "```",
        --   '{"kanban-plugin":"basic"}',
        --   "```",
        --   "%%",
        -- },
      },-- markdown

    })
  end,
}
