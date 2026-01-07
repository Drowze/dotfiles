--https://github.com/neovim/nvim-lspconfig/blob/v2.5.0/lsp/codebook.lua

return {
  cmd = require('drowze.utils').mise_cmd({ 'codebook-lsp', 'serve' }, { tool = 'rust@latest' }),
  filetypes = {
    'css',
    'gitcommit',
    'html',
    'javascript',
    'javascriptreact',
    'lua',
    'markdown',
    'python',
    'ruby',
    'toml',
    'text',
    'typescript',
    'typescriptreact',
  },
  root_markers = { '.git', 'codebook.toml', '.codebook.toml' },
}
