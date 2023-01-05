local dap = require('dap')
local dap_python = require('dap-python')
local dap_ui = require('dapui')

local function dap_map(mode, key, action, desc)
  vim.keymap.set(mode, key, action, { desc = 'DAP: ' .. desc })
end

dap_map('n', '<F5>', dap.continue, 'launch/resume debug session')
dap_map('n', '<leader>b', dap.toggle_breakpoint, 'toggle [b]reakpoint')
dap_map('n', '<F12>', dap_ui.toggle, 'toggle UI')

dap_python.setup('~/.virtualenvs/debugpy/bin/python')
dap_ui.setup()
