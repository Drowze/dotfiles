-- https://github.com/neovim/nvim-lspconfig/blob/v2.5.0/lsp/yamlls.lua
return {
  cmd = require('drowze.utils').mise_cmd({ 'yaml-language-server', '--stdio' }, { tool = 'node@latest' }),
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' },
  root_markers = { '.git' },
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = { format = { enable = true } },
  },
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = true
  end,
}
