local Util = require("lazyvim.util")
local actions = require("telescope.actions")

return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },
      file_ignore_patterns = { ".git/", "node_modules" },
      mappings = {
        i = {
          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<M-u>"] = actions.results_scrolling_down,
          ["<M-d>"] = actions.results_scrolling_up,
        },
      },
    },
    pickers = {
      find_files = {
        find_command = { "rg", "--files", "--hidden", "-g", "!.git", "--no-ignore-vcs" },
      },
    },
  },
  keys = {
    { "<leader>/", false },
    { "<leadeR>fg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
    { "<leadeR>fG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
  },
}
