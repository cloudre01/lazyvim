-- local events = require("neo-tree.events")
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 35,
      },
      filesystem = {
        visible = true,
        commands = {
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
        },
      },
    },
  },
}
