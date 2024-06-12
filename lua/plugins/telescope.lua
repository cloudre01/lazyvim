local Util = require("lazyvim.util")
local actions = require("telescope.actions")

local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")

local flatten = vim.tbl_flatten

-- i would like to be able to do telescope
-- and have telescope do some filtering on files and some grepping

local multi_rg = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
  opts.shortcuts = opts.shortcuts
    or {
      ["l"] = "*.lua",
      ["v"] = "*.vim",
      ["n"] = "*.{vim,lua}",
      ["t"] = "*.ts",
      ["c"] = "*.c",
      ["r"] = "*.rs",
      ["g"] = "*.go",
    }
  opts.pattern = opts.pattern or "%s"

  local custom_grep = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local prompt_split = vim.split(prompt, "  ")
      local last_segment = prompt_split[#prompt_split]

      local args = { "rg" }
      if prompt_split[1] then
        table.insert(args, "-e")
        table.insert(args, prompt_split[1])
      end

      if last_segment and last_segment ~= prompt_split[1] then
        table.insert(args, "-g")

        local pattern
        if opts.shortcuts[last_segment] then
          pattern = opts.shortcuts[last_segment]
        else
          pattern = last_segment
        end

        table.insert(args, string.format(opts.pattern, pattern))
      end

      return flatten({
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
      })
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "Live Grep (with shortcuts)",
      finder = custom_grep,
      previewer = conf.grep_previewer(opts),
      sorter = require("telescope.sorters").empty(),
    })
    :find()
end

return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },
      file_ignore_patterns = { ".git/", "node_modules" },
      mappings = {
        i = {
          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<M-u>"] = actions.results_scrolling_down,
          ["<M-d>"] = actions.results_scrolling_up,
        },
      },
    },
  },
  keys = {
    { "<leader>/", false },
    { "<leader>fG", LazyVim.pick("live_grep"), desc = "Grep (root dir)" },
    { "<leader>fg", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    { "<leader>ff", LazyVim.pick("find_files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader>fm", multi_rg, desc = "Live grep (with shortcuts)" },
  },
}
