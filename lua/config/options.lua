-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.wo.conceallevel = 0
vim.g.codeium_disable_bindings = 1
vim.g.tmux_navigator_no_mappings = 1
vim.filetype.add({
  extension = {
    conf = "conf",
    env = "sh",
    tiltfile = "tiltfile",
    Tiltfile = "tiltfile",
  },
  filename = {
    [".env"] = "sh",
    ["tsconfig.json"] = "jsonc",
    [".yamlfmt"] = "yaml",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "sh",
  },
})
