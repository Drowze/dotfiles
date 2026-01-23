-- https://github.com/neovim/nvim-lspconfig/blob/v2.5.0/lsp/jsonls.lua
return {
  cmd = require('drowze.utils').mise_cmd({ 'vscode-json-language-server', '--stdio' }, { tool = 'npm:vscode-langservers-extracted' }),
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git' },
}
