local function winbar_json_path()
  local path = require('jsonpath').get() or ''
  return 'jq: ' .. path
end

local function winbar_yaml_path()
  local path = require('yaml_nvim').get_yaml_key() or ''
  return 'yq: .' .. path
end

local function winbar_get_path_build_extension(get_path_func, filetypes)
  return {
    winbar = { lualine_x = { get_path_func } },
    inactive_winbar = {
      lualine_x = { { get_path_func, color = { fg = 'NonText', gui='italic' } } },
    },
    filetypes = filetypes
  }
end

local function treesitter_status()
  local ts_state = require('drowze.utils').treesitter_state()

  if ts_state.available and not ts_state.installed then
    return '⚠️ No treesitter'
  else
    return ''
  end
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'dracula', -- NOTE: this is the built-in dracula theme, not the dracula.nvim plugin
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 100,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {
        'lsp_status',
        'filetype',
        { treesitter_status, color = { fg = 'DiagnosticWarn', gui = 'bold' } },
      },
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {
      lualine_x = {} -- populated by extensions below
    },
    extensions = {
      winbar_get_path_build_extension(winbar_yaml_path, { 'yaml' }),
      winbar_get_path_build_extension(winbar_json_path, { 'json' }),
    }
  }
}
