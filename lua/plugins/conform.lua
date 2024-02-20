return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        pg_format = {
          prepend_args = { "-B" },
        },
      },
      formatters_by_ft = {
        sql = { "pg_format" },
        ["astro"] = { "prettier" },
      },
    },
  },
}
