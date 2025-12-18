-- https://github.com/neovim/nvim-lspconfig/blob/v2.5.0/lsp/quick_lint_js.lua
return {
  cmd = require('drowze.utils').mise_cmd({ 'quick-lint-js', '--lsp-server' }, { tool = 'node@latest' }),
  filetypes = { 'javascript', 'typescript' },
  root_markers = { 'package.json', 'jsconfig.json', '.git' },
}
