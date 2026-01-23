local api = vim.api
local lsp = vim.lsp
local log = vim.lsp.log
local diagnostic = vim.diagnostic

-- enable lsp handlers
lsp.enable({
  'actionsls',
  'bashls',
  'cssls',
  'codebook',
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

local function set_lsp_keymaps(buf)
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
  local function lsp_definitions_alt() require('telescope.builtin').lsp_definitions({ jump_type="never" }) end
  local function lsp_code_actions() require("tiny-code-action").code_action() end
  local function lsp_references() require('telescope.builtin').lsp_references() end
  local function lsp_document_symbols() require('telescope.builtin').lsp_document_symbols() end
  local function workspace_symbols()
    require('telescope.builtin').lsp_workspace_symbols({
      fname_width = 50,
      symbol_width = 50,
      ignore_symbols = { "property" }
    })
  end

  local map = vim.keymap.set
  map('n', 'gD', lsp_definitions, { desc = 'LSP: Definitions', buffer = buf }) -- overwrites a default (non-lsp) keymap
  map('n', 'gd', lsp_definitions_alt, { desc = 'LSP: Definitions (vsplit)' }) -- overwrites a default (non-lsp) keymap
  map({ 'n', 'x' }, 'gra', lsp_code_actions, { desc = 'LSP: Code actions' }) -- overwrites a default keymap
  map('n', 'grr', lsp_references, { desc = 'LSP: References' }) -- overwrites a default keymap
  map('n', 'gO', lsp_document_symbols, { desc = 'LSP: Document symbols' }) -- overwrites a default keymap
  map('n', '<leader>ws', workspace_symbols, { desc = 'LSP: Workspace symbols' })
  map('n', 'go', lsp.buf.type_definition, { desc = 'LSP: Type definition' })
  map({'n', 'x'}, '<F3>', lsp.buf.format, { desc = 'LSP: Format' })
  map('n', '<leader>cl', lsp.codelens.run, { desc = 'LSP: CodeLens run' })
end

api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    set_lsp_keymaps(event.buf)
  end
})

log.set_level('trace') -- comment out after debugging
if log.get_level() < lsp.log.levels.INFO then -- only auto-delete if log level is verbose
  api.nvim_create_autocmd('VimLeave', {
    desc = 'Clear log file on exit',
    callback = function() os.remove(log.get_filename()) end
  })
end
