local colors = {
  light_gray = "#9c9a9a",
}

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
      on_highlights = function(hl, _)
        hl.lineNrAbove = { fg = colors.light_gray }
        hl.lineNrBelow = { fg = colors.light_gray }
      end,
    },
  },
}
