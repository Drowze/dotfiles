vim.fn.sign_define('DiagnosticSignError', { text = '❌', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '🟡', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

-- disable diagnosis text on the right
vim.diagnostic.config({
  severity_sort = true,
  -- virtual_text = false, # TODO: add some way to toggle virtual_text
  float = {
    style = 'minimal',
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },
})
-- grey virtual text
for _, group_name in pairs({
  'DiagnosticVirtualTextError',
  'DiagnosticVirtualTextWarn',
  'DiagnosticVirtualTextInfo',
  'DiagnosticVirtualTextHint',
  'DiagnosticVirtualTextOk',
}) do
  vim.api.nvim_set_hl(0, group_name, { link = 'LineNr' })
end

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


vim.api.nvim_create_user_command('LspToggle',
  function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled( { bufnr = 0 }), { bufnr = 0 })
  end,
  { desc = 'Toggle LSP' }
)

vim.api.nvim_create_autocmd(
  { 'BufNewFile', 'BufRead' },
  {
    desc = 'Disable LSP by filename',
    pattern = '.env,.env.*',
    command = 'LspToggle',
  }
)

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    -- Replace these with whatever servers you want to install
    'solargraph',
    'rubocop',
    'lua_ls',
    'bashls',
    'vimls',
    -- 'ruby_ls',
  }
})

local lspconfig = require('lspconfig')
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities = vim.tbl_deep_extend('force', lsp_capabilities, require('cmp_nvim_lsp').default_capabilities())
-- vim.lsp.set_log_level("debug") -- comment out after debugging

require('mason-lspconfig').setup_handlers({
  function (server_name)
    lspconfig[server_name].setup({})
  end,
  -- ['ruby_ls'] = function()
  --   lspconfig.ruby_ls.setup({
  --     cmd = { "bundle", "exec", "ruby-lsp" },
  --     capabilities = lsp_capabilities,
  --     init_options = {
  --       formatter = 'rubocop',
  --       enabledFeatures = {
  --         "codeActions",
  --         "diagnostics",
  --         "documentHighlights",
  --         "documentLink",
  --         "documentSymbols",
  --         "foldingRanges",
  --         "formatting",
  --         "hover",
  --         "inlayHint",
  --         "onTypeFormatting",
  --         "selectionRanges",
  --         "semanticHighlighting",
  --         "completion",
  --         "codeLens",
  --         "definition",
  --         "workspaceSymbol",
  --         "signatureHelp"
  --       }
  --     },
  --   })
  -- end,
  ['rubocop'] = function()
    lspconfig.rubocop.setup({
      single_file_support = true,
      capabilities = lsp_capabilities
    })
  end,
  ['solargraph'] = function()
    lspconfig.solargraph.setup({
      cmd = { 'solargraph', 'stdio' },
      settings = {
        solargraph = {
          diagnostics = true,
          formatting = false, -- rely on rubocop LSP for diagnostics
          autoformat = false, -- rely on rubocop LSP for diagnostics
          logLevel = 'warn',
        },
      },
      init_options = { formatting = false },
      filetypes = { 'ruby' },
      root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
      capabilities = lsp_capabilities,
      single_file_support = true,
    })
  end,
  ['vimls'] = function()
    lspconfig.vimls.setup({
      capabilities = lsp_capabilities
    })
  end,
  ['lua_ls'] = function()
    lspconfig.lua_ls.setup {
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
          return
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          diagnostics = {
            globals = { "vim" }
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- Depending on the usage, you might want to add additional paths here.
              "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        })
      end,
      settings = {
        Lua = {}
      }
    }
  end
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

-- local lsp = require('lsp-zero')
-- local lspconfig = require('lspconfig')
-- 
-- lsp.preset('recommended')
-- 
-- lsp.ensure_installed({
--   'lua_ls',
--   'solargraph',
--   'rubocop'
-- })
-- 
-- local cmp = require('cmp')
-- local cmp_select = {behavior = cmp.SelectBehavior.Select}
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--   ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--   ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--   ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--   ['<C-Space>'] = cmp.mapping.complete(),
-- })
-- 
-- -- disable completion with tab
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil
-- 
-- lsp.setup_nvim_cmp({
--   mapping = cmp_mappings
-- })
-- 
-- lsp.configure('solargraph', {
--   cmd = { 'solargraph', 'stdio' },
--   filetypes = { "ruby" },
--   init_options = { formatting = false },
--   root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
--   settings = {
--     solargraph = {
--       formatting = false,
--     }
--   }
-- })
-- 
-- lsp.nvim_workspace()
-- 
-- lsp.set_preferences({
--     suggest_lsp_servers = false
-- })
-- 
-- lsp.set_sign_icons({
--     error = '✘',
--     warn = '▲',
--     hint = '⚑',
--     info = ''
-- })
-- 
-- -- disable diagnosis text on the right
-- vim.diagnostic.config({
--   severity_sort = true,
--   virtual_text = false,
--   float = {
--     style = 'minimal',
--     border = 'rounded',
--     source = 'always',
--     header = '',
--     prefix = '',
--   },
-- })
-- 
-- lsp.on_attach(function(client, bufnr)
--   lsp.default_keymaps({buffer = bufnr}) -- lsp-zero defaults
--   
--   -- K: Displays hover information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.hover().
--   -- gd: Jumps to the definition of the symbol under the cursor. See :help vim.lsp.buf.definition().
--   -- gD: Jumps to the declaration of the symbol under the cursor. Some servers don't implement this feature. See :help vim.lsp.buf.declaration().
--   -- gi: Lists all the implementations for the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.implementation().
--   -- go: Jumps to the definition of the type of the symbol under the cursor. See :help vim.lsp.buf.type_definition().
--   -- gr: Lists all the references to the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.references().
--   -- gs: Displays signature information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.signature_help(). If a mapping already exists for this key this function is not bound.
--   -- <F2>: Renames all references to the symbol under the cursor. See :help vim.lsp.buf.rename().
--   -- <F3>: Format code in current buffer. See :help vim.lsp.buf.format().
--   -- <F4>: Selects a code action available at the current cursor position. See :help vim.lsp.buf.code_action().
--   -- gl: Show diagnostics in a floating window. See :help vim.diagnostic.open_float().
--   -- [d: Move to the previous diagnostic in the current buffer. See :help vim.diagnostic.goto_prev().
--   -- ]d: Move to the next diagnostic. See :help vim.diagnostic.goto_next().
-- end)
-- 
-- -- vim.lsp.set_log_level("debug")
-- 
-- lsp.setup()
