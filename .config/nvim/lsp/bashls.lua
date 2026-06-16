-- https://github.com/neovim/nvim-lspconfig/blob/v2.5.0/lsp/bashls.lua
return {
  cmd = require('drowze.utils').mise_cmd({'bash-language-server', 'start'}, { tool = 'npm:bash-language-server' }),
  filetypes = { 'bash', 'sh' },
  root_markers = { '.git' },
  settings = {
    bashIde = {
      -- Glob pattern for finding and parsing shell script files in the workspace.
      -- Used by the background analysis features across files.

      -- Prevent recursive scanning which will cause issues when opening a file
      -- directly in the home directory (e.g. ~/foo.sh).
      --
      -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
      globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
      shellcheckPath = 'shellcheck',
    },
  },
  on_init = function(client)
    -- it's not possible to pass shellcheckPath in the `mise exec ...` format, so
    -- we lazily resolve it during initialization
    local shellcheckPath = vim.fn.system('mise which shellcheck --tool=shellcheck@latest')
    if vim.v.shell_error == 0 then
      client.config.settings.bashIde.shellcheckPath = shellcheckPath:gsub('\n$', '')
    end
  end,
}
