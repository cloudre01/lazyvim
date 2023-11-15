-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Example to remove conceal
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "markdown" },
--   callback = function()
--     vim.wo.conceallevel = 0
--   end,
-- })

-- check the number of windows opened
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   callback = function()
--     vim.cmd("echo 'Number of windows: " .. vim.fn.winnr() .. "'")
--     -- local number_of_windows = #vim.api.nvim_list_wins()
--     local current_buffer = vim.api.nvim_get_current_buf()
--     local buffer_name = vim.api.nvim_buf_get_name(current_buffer)
--     local bufinfo = vim.fn.getbufinfo(current_buffer)[1]
--     print("Current buffer name: " .. bufinfo.name:match(".*NvimTree_%d*$"))
--     -- print(number_of_windows)
--   end,
-- })

-- when cmp completion is loaded, clear the virtual text from codium
require("cmp").event:on("menu_opened", function()
  vim.fn["codeium#Clear"]()
end)
