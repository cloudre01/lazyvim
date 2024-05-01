-- local events = require("neo-tree.events")
local function getTelescopeOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if filename == nil then
          filename = selection[1]
        end
        local lnum = selection.lnum
        local col = selection.col
        -- any way to open the file without triggering auto-close event of neo-tree?
        -- require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
        vim.cmd("edit " .. filename)
        if lnum ~= nil and col ~= nil then
          vim.schedule(function()
            vim.api.nvim_win_set_cursor(0, { lnum, col - 1 })
          end)
        end
      end)
      return true
    end,
  }
end
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["<leader>ff"] = {
            "telescope_find",
            desc = "Find file (in node directory)",
          },
          ["<leader>fg"] = {
            "telescope_grep",
            desc = "Grep (in node directory)",
          },
          ["o"] = {
            "system_open",
            desc = "System open",
          },
        },
        width = 35,
      },
      filesystem = {
        filtered_items = {
          visible = true,
        },
        check_gitignore_in_search = false,
        commands = {
          system_open = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.jobstart({ "open", path }, { detach = true })
          end,
          delete = function(state)
            local inputs = require("neo-tree.ui.inputs")
            local path = state.tree:get_node().path
            local msg = "Are you sure you want to trash " .. path
            inputs.confirm(msg, function(confirmed)
              if not confirmed then
                return
              end

              vim.fn.system({ "trash", vim.fn.fnameescape(path) })
              require("neo-tree.sources.manager").refresh(state.name)
            end)
          end,
          delete_visual = function(state, selected_nodes)
            local cmds = require("neo-tree.sources.filesystem.commands")
            local paths_to_trash = {}
            for _, node in ipairs(selected_nodes) do
              if node.type ~= "message" then
                table.insert(paths_to_trash, node.path)
              end
            end

            local msg = "Are you sure you want to trash " .. #paths_to_trash .. " items?"
            local inputs = require("neo-tree.ui.inputs")
            inputs.confirm(msg, function(confirmed)
              if not confirmed then
                return
              end
              for _, path in ipairs(paths_to_trash) do
                vim.api.nvim_command("silent !trash -F " .. path)
              end
              cmds.refresh(state)
            end)
          end,
          telescope_find = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            require("telescope.builtin").find_files(getTelescopeOpts(state, path))
          end,
          telescope_grep = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            require("telescope.builtin").live_grep(getTelescopeOpts(state, path))
          end,
        },
      },
    },
  },
}
