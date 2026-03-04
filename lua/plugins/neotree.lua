-- local events = require("neo-tree.events")

local function get_node_search_path(state)
  local node = state.tree:get_node()
  local path = node:get_id()
  local stat = (vim.uv or vim.loop).fs_stat(path)
  if stat and stat.type == "file" then
    return vim.fn.fnamemodify(path, ":h")
  end
  return path
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", "<leader>fE", desc = "Explorer NeoTree (Root Dir)", remap = true },
      { "<leader>E", "<leader>fe", desc = "Explorer NeoTree (cwd)", remap = true },
    },
    opts = {
      window = {
        mappings = {
          ["<leader>ff"] = {
            "snacks_find",
            desc = "Find file (in node directory)",
          },
          ["<leader>fg"] = {
            "snacks_grep",
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
          snacks_find = function(state)
            local path = get_node_search_path(state)
            Snacks.picker.files({
              cwd = path,
              dirs = { path },
            })
          end,
          snacks_grep = function(state)
            local path = get_node_search_path(state)
            Snacks.picker.grep({
              cwd = path,
              dirs = { path },
            })
          end,
        },
      },
    },
  },
}
