-- https://github.com/neovim/nvim-lspconfig/blob/v2.5.0/lsp/vimls.lua
return {
  cmd = require('drowze.utils').mise_cmd({'vim-language-server', '--stdio'}, { tool = 'node@latest' }),
  filetypes = { 'vim' },
  root_markers = { '.git' },
  init_options = {
    isNeovim = true,
    iskeyword = '@,48-57,_,192-255,-#',
    vimruntime = '',
    runtimepath = '',
    diagnostic = { enable = true },
    indexes = {
      runtimepath = true,
      gap = 100,
      count = 3,
      projectRootPatterns = { 'runtime', 'nvim', '.git', 'autoload', 'plugin' },
    },
    suggest = { fromVimruntime = true, fromRuntimepath = true },
  },
}
