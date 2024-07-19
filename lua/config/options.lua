-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.wo.conceallevel = 2
vim.g.codeium_disable_bindings = 1
vim.g.tmux_navigator_no_mappings = 1
vim.g.copilot_no_tab_map = true
vim.filetype.add({
  extension = {
    conf = "conf",
    env = "sh",
    log = "log",
    tiltfile = "tiltfile",
    Tiltfile = "tiltfile",
  },
  filename = {
    [".env"] = "dotenv",
    ["tsconfig.json"] = "jsonc",
    [".yamlfmt"] = "yaml",
    ["*.log"] = "log",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
})
