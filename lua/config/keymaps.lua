-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local Util = require("lazyvim.util")
local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Codeium
keymap("i", "<A-a>", function()
  return vim.fn["codeium#Accept"]()
end, { noremap = true, silent = true, expr = true, replace_keycodes = false, desc = "Codeium Accept" })
keymap("i", "<A-[>", function()
  return vim.fn["codeium#CycleCompletions"](1)
end, { noremap = true, silent = true, expr = true, desc = "Codeium Next" })
keymap("i", "<A-]>", function()
  return vim.fn["codeium#CycleCompletions"](-1)
end, { noremap = true, silent = true, expr = true, desc = "Codeium Previous" })
keymap("n", "<leader>ac", function()
  return vim.fn["codeium#Chat"]()
end, { noremap = true, silent = true, expr = true, desc = "Codeium Chat" })

-- Copilot
-- vim.keymap.set("i", "<A-a>", 'copilot#Accept("\\<A-a>")', {
--   expr = true,
--   replace_keycodes = false,
-- })
-- vim.g.copilot_no_tab_map = true

-- Normal --
keymap("n", [[<C-\>]], lazyterm, { desc = "Open Terminal" })

-- Terminal --
keymap("t", [[<C-\>]], "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Tmux sessionizer
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)

-- Git
keymap("n", "<leader>gb", "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", { desc = "Toggle blame" })
