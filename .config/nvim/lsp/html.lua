-- https://github.com/neovim/nvim-lspconfig/blob/v2.10.0/lsp/html.lua
return {
  cmd = require('drowze.utils').mise_cmd({ 'vscode-html-language-server', '--stdio' }, { tool = 'npm:vscode-langservers-extracted' }),
  filetypes = { 'html' },
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { 'html', 'css', 'javascript' },
  },
  root_markers = { 'package.json', '.git' },
}
