return {
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<C-h>", vim.cmd.TmuxNavigateLeft, desc = "Tmux Navigate Left" },
      { "<C-j>", vim.cmd.TmuxNavigateDown, desc = "Tmux Navigate Down" },
      { "<C-k>", vim.cmd.TmuxNavigateUp, desc = "Tmux Navigate Up" },
      { "<C-l>", vim.cmd.TmuxNavigateRight, desc = "Tmux Navigate Right" },
    },
  },
}
