return {
  -- correctly install lsp with mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "graphql-language-service-cli",
        "prisma-language-server",
        "sqlls",
        "sql-formatter",
        "astro-language-server",
        "js-debug-adapter",
        "ruff",
        "mypy",
      })
    end,
  },
}
