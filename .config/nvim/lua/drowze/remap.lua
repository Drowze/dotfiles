vim.g.mapleader = ' '

local keymap = vim.keymap.set
--vim.keymap.set('n', '<leader>pv', vim.cmd.Oil, { desc = 'Open Oil' })
keymap('n', '<leader>q', ':bp<bar>sp<bar>bn<bar>bd<CR>', { desc = 'Close buffer but do not close window (opens previous buffer)' })
keymap('t', '<ESC>', '<C-\\><C-n>', { silent = true })
