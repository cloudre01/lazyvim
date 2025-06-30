return {
  {
    "sindrets/diffview.nvim",
    opts = {
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
    },
    keys = {
      {
        "<leader>gdb",
        function()
          require("telescope.builtin").git_branches({
            prompt_title = "Select branch to diff against",
            attach_mappings = function(_, map)
              map("i", "<CR>", function(prompt_bufnr)
                local actions = require("telescope.actions")
                local state = require("telescope.actions.state")
                local selection = state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection and selection.value then
                  vim.cmd("DiffviewOpen " .. selection.value)
                end
              end)
              return true
            end,
          })
        end,
        desc = "Diffview Branch",
      },
      {
        "<leader>gdc",
        "<cmd>DiffviewClose<cr>",
        desc = "Close Diffview",
      },
      {
        "<leader>gdf",
        "<cmd>DiffviewFileHistory %<cr>",
        desc = "File History",
      },
      {
        "<leader>gdh",
        function()
          require("telescope.builtin").git_commits({
            prompt_title = "Select commit to diff against",
            attach_mappings = function(_, map)
              map("i", "<CR>", function(prompt_bufnr)
                local actions = require("telescope.actions")
                local state = require("telescope.actions.state")
                local selection = state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection and selection.value then
                  vim.cmd("DiffviewOpen " .. selection.value)
                end
              end)
              return true
            end,
          })
        end,
        desc = "Diffview Commit",
      },
    },
  },
}
