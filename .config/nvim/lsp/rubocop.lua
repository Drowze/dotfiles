-- https://github.com/neovim/nvim-lspconfig/blob/v2.5.0/lsp/rubocop.lua
return {
  cmd = require('drowze.utils').mise_cmd({'rubocop', '--lsp'}, { tool = 'ruby' }),
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile', '.git' },
  single_file_support = true,
}
