return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "markdown",
        "markdown_inline",
        "bash",
        "python",
        "rust",
        "html",
        "tsx",
        "javascript",
        "go",
        "sql",
        "zig",
        "graphql",
        "scss",
        "css",
        "prisma",
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
      end

      vim.treesitter.language.register("bash", "dotenv")

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
