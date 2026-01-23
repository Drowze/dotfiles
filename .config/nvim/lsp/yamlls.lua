-- https://github.com/neovim/nvim-lspconfig/blob/v2.5.0/lsp/yamlls.lua
return {
  cmd = require('drowze.utils').mise_cmd({ 'yaml-language-server', '--stdio' }, { tool = 'npm:yaml-language-server' }),
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' },
  root_markers = { '.git' },
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      format = { enable = true },
      schemas = {
        -- https://github.com/redhat-developer/vscode-yaml/issues/245
        ["https://gist.githubusercontent.com/Drowze/ba1969a9139e880804b69c85a0022d0f/raw/empty-json-schema.json"] = "lib/defaults/*.yml"
      },
    },
  },
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = true
  end,
}
