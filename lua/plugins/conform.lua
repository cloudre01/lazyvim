-- Function to disable formatting for .env files
--- Disable formatting for .env files.
-- This function checks if the current buffer corresponds to a .env file and disables formatting if it does.
-- @param ctx table The context table containing the command information.
-- @return boolean Returns false if the file is a .env file, true otherwise.
local function disable_formatting_for_env_files(_)
  -- Get the name of the current buffer
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)

  -- Check if the filename ends with .env and return false if it does
  return not filename:match("%.env.*")
end

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        injected = { options = { ignore_errors = true } },
        pg_format = {
          prepend_args = { "-B" },
        },
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
          condition = disable_formatting_for_env_files,
        },
      },
      formatters_by_ft = {
        sql = { "pg_format" },
        ["astro"] = { "prettier" },
      },
    },
  },
}
