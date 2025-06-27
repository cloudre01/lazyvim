return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>sg",
        function()
          local actions = require("telescope.actions")
          local action_state = require("telescope.actions.state")
          local builtin = require("telescope.builtin")

          local function grep_with_glob(opts)
            opts = opts or {}
            opts.cwd = require("lazyvim.util").root.get()

            opts.attach_mappings = function(_, map)
              map({ "n", "i" }, "<C-m>", function(prompt_bufnr)
                local input = action_state.get_current_line():gsub("%c", "")
                actions.close(prompt_bufnr)

                Snacks.input({
                  prompt = "Glob pattern (e.g. *.ts): ",
                }, function(glob)
                  if glob then
                    vim.cmd("stopinsert")
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
        end,
        desc = "Grep (Root Dir) + glob",
      },
    },
  },
}
