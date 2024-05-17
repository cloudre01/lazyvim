local M = {}

function M.get_venv()
  local cwd = vim.fn.getcwd()
  local venv_dir = cwd .. "/.venv"
  if vim.fn.isdirectory(venv_dir) == 1 then
    return cwd .. "/.venv/bin/python"
  end

  return vim.fn.exepath("python3")
end

return M
