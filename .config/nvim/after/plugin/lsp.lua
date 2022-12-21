local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'sumneko_lua',
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

lsp.setup_servers({ 'ruby' })
lsp.nvim_workspace()

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
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
