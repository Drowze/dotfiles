vim.g.mapleader = ' '

local keymap = vim.keymap.set

keymap('n', '<leader>q', ':bp<bar>sp<bar>bn<bar>bd<CR>', { desc = 'Close buffer but do not close window (opens previous buffer)' })
keymap('t', '<ESC>', '<C-\\><C-n>', { silent = true })

keymap('n', '<leader>bn', ':bn<CR>', { desc = 'Next buffer', silent = true })
keymap('n', '<leader>bp', ':bp<CR>', { desc = 'Previous buffer', silent = true })
