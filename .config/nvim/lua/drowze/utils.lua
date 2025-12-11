local M = {}

-- https://github.com/ibhagwan/fzf-lua/blob/a1f834b37506ca77c47fa99cd3f5e9ed3f4102d2/lua/fzf-lua/utils.lua#L196-L209
function M.rg_escape(str)
  if not str then return str end
  -- [(~'"\/$?'`*&&||;[]<>)]
  -- escape "\~$?*|[()^-"
  -- local ret = str:gsub("[\\~$?*|{\\[()^%-%+]", function(x)
  local ret = str:gsub("[\\~$|{\\[()^%-%+]", function(x)
        return "\\" .. x
      end)
      -- Escape newline at the end so we
      -- don't end up escaping the backslash twice
      :gsub("\n", "\\n")
  return ret
end

-- https://github.com/nvim-telescope/telescope.nvim/blob/df534c3042572fb958586facd02841e10186707c/lua/telescope/builtin/__files.lua#L201-L205
function M.get_visual_selection()
  if not vim.fn.mode() == "v" then
    return ""
  end

  local saved_reg = vim.fn.getreg "v"
  vim.cmd [[noautocmd sil norm! "vy]]
  local selection = vim.fn.getreg "v"
  vim.fn.setreg("v", saved_reg)
  return selection
end

function M.mise_cmd(raw_cmd, opts)
  if not (type(raw_cmd) == 'table') then
    raw_cmd = { raw_cmd }
  end

  if not (vim.fn.executable('mise') == 1) then
    return raw_cmd
  end

  local cmd = { 'mise', 'exec' }
  if opts and opts.tool then
    table.insert(cmd, opts.tool)
  end
  table.insert(cmd, '--')
  for _, v in pairs(raw_cmd) do
    table.insert(cmd, v)
  end

  return cmd
end

-- Get the current (relative) path of the file in the current buffer
function M.get_current_path()
  local current_path
  local current_filetype = vim.api.nvim_get_option_value("filetype", {})

  if current_filetype == "netrw" then
    current_path = vim.b.netrw_curdir
  elseif current_filetype == "oil" then
    current_path = require('oil').get_current_dir()
  else
    current_path = vim.fn.expand "%:p:h"
  end

  -- try to get a relative path
  local relative_path = vim.fn.fnamemodify(current_path, ":.")

  if relative_path == "" then
    return current_path
  else
    return relative_path
  end
end

return M
