--https://github.com/neovim/nvim-lspconfig/blob/v2.5.0/lsp/codebook.lua

return {
  cmd = require('drowze.utils').mise_cmd({ 'codebook-lsp', 'serve' }, { tool = 'aqua:blopker/codebook' }),
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
  init_options = {
    logLevel = 'info',
    -- global_config_path = nil,
    checkWhileTyping = true,
    diagnosticSeverity = 'hint',
  },
  on_init = function(client)
    -- Disable signs for Codebook diagnostics; keep only underlined text
    local diagnostic_namespace = vim.lsp.diagnostic.get_namespace(client.id)
    vim.diagnostic.config({ signs = false }, diagnostic_namespace)
  end,
}
