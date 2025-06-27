-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set
local keymap_del = vim.keymap.del
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
  return vim.fn["copilot#Accept"]()
end, { noremap = true, silent = true, expr = true, replace_keycodes = false, desc = "Codeium Accept" })
-- keymap("i", "<A-[>", function()
--   return vim.fn["codeium#CycleCompletions"](1)
-- end, { noremap = true, silent = true, expr = true, desc = "Codeium Next" })
-- keymap("i", "<A-]>", function()
--   return vim.fn["codeium#CycleCompletions"](-1)
-- end, { noremap = true, silent = true, expr = true, desc = "Codeium Previous" })
-- keymap("n", "<leader>ac", function()
--   return vim.fn["codeium#Chat"]()
-- end, { noremap = true, silent = true, expr = true, desc = "Codeium Chat" })

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
keymap("n", "<leader>gB", "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", { desc = "Toggle blame" })

-- Kulala
keymap("n", "<leader>Rs", "<cmd>lua require('kulala').scratchpad()<cr>", { desc = "Open scratchpad" })

-- Telescope
keymap_del("n", "<leader>sg")
keymap("n", "<leader>sg", function()
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local builtin = require("telescope.builtin")

  local function grep_with_glob(_opts)
    opts = _opts or {}
    opts.cwd = require("lazyvim.util").root.get()

    opts.attach_mappings = function(_, map)
      map({ "n", "i" }, "<C-m>", function(prompt_bufnr)
        local input = action_state.get_current_line():gsub("%c", "")
        actions.close(prompt_bufnr)

        Snacks.input({
          prompt = "Glob pattern (e.g. *.ts): ",
        }, function(glob)
          vim.cmd("stopinsert")
          if glob then
            vim.schedule(function()
              grep_with_glob({
                default_text = input,
                glob_pattern = glob,
              })
            end)
          end
        end)

        vim.defer_fn(function()
          vim.cmd("startinsert")
        end, 10)
      end, { noremap = true, silent = true })

      return true
    end

    builtin.live_grep(opts)
  end

  grep_with_glob()
end, { desc = "Grep (Root Dir) + glob" })
