local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'lua_ls',
  'solargraph'
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})

-- disable completion with tab
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

-- TODO: can this be lazy? e.g. only cat Gemfile.lock on ruby files
local solargraph_cmd = function()
  local ret_code = nil
  local jid = vim.fn.jobstart("cat Gemfile.lock | grep solargraph", { on_exit = function(_, data) ret_code = data end })
  vim.fn.jobwait({ jid }, 5000)
  if ret_code == 0 then
    return { "bundle", "exec", "solargraph", "stdio" }
  end
  return { "solargraph", "stdio" }
end

lsp.configure('solargraph', { cmd = solargraph_cmd() })
lsp.nvim_workspace()

lsp.set_preferences({
    suggest_lsp_servers = false
})
lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = ''
})

-- disable diagnosis text on the right
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = false,
  float = {
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

lsp.on_attach(function(client, bufnr)
  local function opts(desc)
    return {
      buffer = bufnr,
      remap = false,
      desc = desc
    }
  end

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts('LSP: [G]o to [d]efinition'))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts('LSP: Show hover information'))
  vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts('LSP: search workspace symbol'))
  vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts('LSP: [v]iew [d]iagnostic'))
  vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts('LSP: goto next'))
  vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts('LSP: goto previous'))
  vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts('LSP: [v]iew [r]ecommended [a]ctions'))
  vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts('LSP: [v]iew [r]eferences'))
  vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts('LSP: rename symbol'))
  vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts('LSP: view signature help'))
end)

lsp.setup()
