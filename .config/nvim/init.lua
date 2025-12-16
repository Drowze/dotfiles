-- Automatically delete lsp log if it's >10MB (value in bytes)
if vim.fn.getfsize(vim.lsp.log.get_filename()) >= 10485760 then
  vim.ui.select({'yes', 'no'}, { prompt = 'LSP log file is >10MB, automatically delete it?' },
  function(choice)
    if choice == 'yes' then vim.fn.delete(vim.lsp.log.get_filename()) end
  end)
end

-- Leader key must be setup before Lazy
vim.g.mapleader = ' '

require('drowze')
vim.opt.termguicolors = true
