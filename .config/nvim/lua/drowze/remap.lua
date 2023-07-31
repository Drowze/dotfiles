vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open netrw' })
vim.keymap.set('n', '<leader>q', ':bp<bar>sp<bar>bn<bar>bd<CR>')
