local api = vim.api
local lsp = vim.lsp
local diagnostic = vim.diagnostic

-- enable lsp handlers
lsp.enable({
  'bashls',
  'cssls',
  'jsonls',
  'lua_ls',
  'quick_lint_js',
  'ruby_lsp',
  'vimls',
  'yamlls',
})

-- grey virtual text (same color as line numbers)
for _, group_name in pairs({
  'DiagnosticVirtualTextError',
  'DiagnosticVirtualTextWarn',
  'DiagnosticVirtualTextInfo',
  'DiagnosticVirtualTextHint',
  'DiagnosticVirtualTextOk',
}) do
  api.nvim_set_hl(0, group_name, { link = 'LineNr' })
end

diagnostic.config({
  severity_sort = true,
  -- virtual_text = true, -- TODO: add some way to toggle virtual_text
  float = {
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },
  signs = {
    text = {
      [diagnostic.severity.ERROR] = '❌',
      [diagnostic.severity.WARN] = '🟡',
      [diagnostic.severity.INFO] = '',
      [diagnostic.severity.HINT] = '',
    },
    linehl = {
      [diagnostic.severity.ERROR] = 'ErrorMsg',
    },
    numhl = {
      [diagnostic.severity.WARN] = 'WarningMsg',
    },
  },
})

api.nvim_create_user_command('LspToggle', function()
    diagnostic.enable(not diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
  end,
  { desc = 'Toggle diagnostics' }
)

-- util LSP commands, as extracted from lspconfig
-- see: https://github.com/neovim/nvim-lspconfig/blob/v2.5.0/plugin/lspconfig.lua
-- TODO: remove `LspRestart` if new `:lsp restart` gets upstream. See: https://github.com/neovim/neovim/pull/35078/changes
api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = 'Open LSP info' })
api.nvim_create_user_command('LspLog', function()
    vim.cmd(string.format('tabnew %s', lsp.log.get_filename()))
  end,
  { desc = 'Open LSP log' }
)
api.nvim_create_user_command('LspRestart', function(info)
  local clients = info.fargs

  -- Default to restarting all active servers
  if #clients == 0 then
    clients = vim
      .iter(lsp.get_clients())
      :map(function(client)
        return client.name
      end)
      :totable()
  end

  for _, name in ipairs(clients) do
    if lsp.config[name] == nil then
      vim.notify(("Invalid server name '%s'"):format(name))
    else
      lsp.enable(name, false)
    end
  end

  local timer = assert(vim.uv.new_timer())
  timer:start(500, 0, function()
    for _, name in ipairs(clients) do
      vim.schedule_wrap(function(x)
        lsp.enable(x)
      end)(name)
    end
  end)
end, {
  desc = 'Restart the given client',
  nargs = '?',
  complete = function(arg)
    return vim
      .iter(lsp.get_clients())
      :map(function(client)
        return client.name
      end)
      :filter(function(name)
        return name:sub(1, #arg) == arg
      end)
      :totable()
  end,
})

api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    -- by default, omnifunc is set to vim.lsp.omnifunc() - use CTRL-X CTRL-O to trigger completion
    --
    -- default keymaps:
    -- K (n): vim.lsp.buf.hover()
    -- grn (n): vim.lsp.buf.rename()
    -- gra (n): vim.lsp.buf.code_action()
    -- grr (n): vim.lsp.buf.references()
    -- gri (n): vim.lsp.buf.implementation()
    -- gO (n): vim.lsp.buf.document_symbol()
    -- CTRL-S (i): vim.lsp.buf.signature_help()

    local function lsp_definitions() require('telescope.builtin').lsp_definitions() end
    local function lsp_definitions_alt() require('telescope.builtin').lsp_definitions({ jump_type="vsplit" }) end
    local function lsp_references() require('telescope.builtin').lsp_references() end
    local function workspace_symbols()
      require('telescope.builtin').lsp_workspace_symbols({
        fname_width = 50,
        symbol_width = 50,
        ignore_symbols = { "property" }
      })
    end

    local function keymap(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = event.buf })
    end

    keymap('n', 'gD', lsp_definitions, 'LSP: Definitions')
    keymap('n', 'gd', lsp_definitions_alt, 'LSP: Definitions (vsplit)')
    keymap('n', 'grr', lsp_references, 'LSP: References')
    keymap('n', '<leader>ws', workspace_symbols, 'LSP: Workspace symbols')
    keymap('n', 'go', lsp.buf.type_definition, 'LSP: Type definition')
    keymap({'n', 'x'}, '<F3>', lsp.buf.format, 'LSP: Format')
  end
})

api.nvim_create_autocmd(
  { 'BufNewFile', 'BufRead' },
  { desc = 'Disable LSP by filename', pattern = '.env,.env.*', command = 'LspToggle' }
)

-- lsp.set_log_level('debug') -- comment out after debugging
