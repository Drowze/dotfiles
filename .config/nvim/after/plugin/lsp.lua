-- grey virtual text (same color as line numbers)
for _, group_name in pairs({
  'DiagnosticVirtualTextError',
  'DiagnosticVirtualTextWarn',
  'DiagnosticVirtualTextInfo',
  'DiagnosticVirtualTextHint',
  'DiagnosticVirtualTextOk',
}) do
  vim.api.nvim_set_hl(0, group_name, { link = 'LineNr' })
end

vim.diagnostic.config({
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
      [vim.diagnostic.severity.ERROR] = '❌',
      [vim.diagnostic.severity.WARN] = '🟡',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
  },
})

vim.api.nvim_create_user_command(
  'LspToggle',
  function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
  end,
  { desc = 'Toggle LSP' }
)

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    -- omnifunc is set to vim.lsp.omnifunc() - use CTRL-X CTRL-O to trigger completion
    --
    -- default keymaps:
    -- K (n): vim.lsp.buf.hover()
    -- grn (n): vim.lsp.buf.rename()
    -- gra (n): vim.lsp.buf.code_action()
    -- grr (n): vim.lsp.buf.references()
    -- gri (n): vim.lsp.buf.implementation()
    -- gO (n): vim.lsp.buf.document_symbol()
    -- CTRL-S (i): vim.lsp.buf.signature_help()

    vim.keymap.set('n', 'gD', function() require('telescope.builtin').lsp_definitions({jump_type="vsplit"}) end, opts)
    vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions() end, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set({'n', 'x'}, '<F3>', function() vim.lsp.buf.format({async = true}) end, opts)
  end
})

vim.api.nvim_create_autocmd(
  { 'BufNewFile', 'BufRead' },
  { desc = 'Disable LSP by filename', pattern = '.env,.env.*', command = 'LspToggle' }
)

-- vim.lsp.set_log_level('debug') -- comment out after debugging

vim.lsp.config('*', {
  capabilities = vim.lsp.protocol.make_client_capabilities()
})

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'solargraph',
    'rubocop',
    'lua_ls',
    'bashls',
    'vimls',
    -- 'ruby_ls',
  }
})


require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}
-- local source_opts = 
cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),

    ['<C-Space>'] = cmp.mapping.complete(),

    -- Jump to the next placeholder in the snippet
    ['<C-f>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    -- Jump to the previous placeholder in the snippet
    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp', keyword_length = 1 },
    { name = 'buffer', keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
  },
  formatting = {
    expandable_indicator = true,
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
})
