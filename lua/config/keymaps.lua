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
end, { noremap = true, silent = true, expr = true, desc = "Codium Previous" })

-- Normal --
keymap("n", [[<C-\>]], lazyterm, { desc = "Open Terminal" })

-- Terminal --
keymap("t", [[<C-\>]], "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Tmux sessionizer
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)
