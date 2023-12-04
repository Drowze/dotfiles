return {
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    end,
    dependencies = { 'mfussenegger/nvim-dap', 'rcarriga/nvim-dap-ui' },
    keys = {
      { '<F12>', function() require('dapui').toggle() end, ft = 'python', desc = 'DAP: toggle UI' }
    }
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap' },
    lazy = true,
    config = function()
      local dapui = require('dapui')
      local dap = require('dap')

      dapui.setup()

      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP: launch/resume debug session' })
      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'DAP: toggle [b]reakpoint' })
    end
  }
}
