vim.g.mapleader = ' '

--vim.keymap.set('n', '<leader>pv', vim.cmd.Oil, { desc = 'Open Oil' })
vim.keymap.set('n', '<leader>q', ':bp<bar>sp<bar>bn<bar>bd<CR>', { desc = 'Close buffer but do not close window (opens previous buffer)' })
