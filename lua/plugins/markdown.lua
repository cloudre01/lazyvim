return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    keys = {
      {
        "<leader>gm",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
        ft = "markdown",
      },
    },
  },
}
