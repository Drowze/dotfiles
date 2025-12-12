-- Automatically delete lsp log if it's >10MB (value in bytes)
if vim.fn.getfsize(vim.lsp.log.get_filename()) >= 10485760 then
  vim.print('LSP log file is >10MB, automatically deleting it')
end

-- Leader key must be setup before Lazy
vim.g.mapleader = ' '

require('drowze')
vim.opt.termguicolors = true
