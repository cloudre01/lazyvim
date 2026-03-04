---@class snacks.Picker
---@field [string] unknown
---@class snacks.picker.Config
---@field [string] unknown

local list_extend = function(where, what)
  return vim.list_extend(vim.deepcopy(where), what)
end

local list_filter = function(where, what)
  -- stylua: ignore
  return vim.iter(where):filter(function(val) return not vim.list_contains(what, val) end):totable()
end

local glob_to_default = function(glob)
  if type(glob) == "table" then
    return table.concat(glob, ",")
  end
  return glob or ""
end

return {
  "folke/snacks.nvim",
  ---@module "snacks"
  ---@class snacks.Config
  opts = {
    picker = {
      layout = "telescope",
      sources = {
        grep = {
          case_sens = false,
          toggles = {
            case_sens = "s",
          },
          finder = function(opts, ctx)
            local args_extend = { "--case-sensitive" }
            opts.args = list_filter(opts.args or {}, args_extend)
            if opts.case_sens then
              opts.args = list_extend(opts.args, args_extend)
            end
            return require("snacks.picker.source.grep").grep(opts, ctx)
          end,
          actions = {
            toggle_live_case_sens = function(picker)
              picker.opts.case_sens = not picker.opts.case_sens
              picker:find()
            end,
            set_live_glob = function(picker)
              Snacks.input({
                prompt = "Glob pattern (e.g. *.ts, empty to clear): ",
                default = glob_to_default(picker.opts.glob),
              }, function(value)
                if value == nil then
                  return
                end
                local glob = vim.trim(value)
                picker.opts.glob = glob ~= "" and glob or nil
                picker:find()
              end)
            end,
          },
          win = {
            input = {
              keys = {
                ["<C-f>"] = { "toggle_live_case_sens", mode = { "i", "n" } },
                ["<C-t>"] = { "set_live_glob", mode = { "i", "n" } },
              },
            },
          },
        },
      },
    },
  },
}
