return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
        ["<C-CR>"] = function(fallback)
          cmp.mapping.abort()
          fallback()
        end,
      })
    end,
  },
}
