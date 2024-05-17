return {
  {
    "garymjr/nvim-snippets",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      friendly_snippets = true,
      extended_filetypes = {
        typescript = {
          "javascript",
        },
      },
    },
  },
}
