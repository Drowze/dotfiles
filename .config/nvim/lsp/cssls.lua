-- https://github.com/neovim/nvim-lspconfig/blob/v2.5.0/lsp/cssls.lua
return {
  cmd = require('drowze.utils').mise_cmd({ 'vscode-css-language-server', '--stdio' }, { tool = 'npm:vscode-langservers-extracted' }),
  filetypes = { 'css', 'scss', 'less' },
  init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
  root_markers = { 'package.json', '.git' },
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}
