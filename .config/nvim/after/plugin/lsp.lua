require("neodev").setup({})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set({'n', 'x'}, '<F3>', function() vim.lsp.buf.format({async = true}) end, opts)
    vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  end
})

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    -- Replace these with whatever servers you want to install
    'solargraph',
    'rubocop',
    'lua_ls',
    'bashls'
  }
})

local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason-lspconfig').setup_handlers({
  function (server_name)
    lspconfig[server_name].setup({})
  end,
  ['solargraph'] = function()
    lspconfig.solargraph.setup({
      capabilities = lsp_capabilities,
      root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
      single_file_support = true,
    })
  end,
  ['lua_ls'] = function()
    lspconfig.lua_ls.setup({
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
          client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
              },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME
                  -- Depending on the usage, you might want to add additional paths here.
                  -- E.g.: For using `vim.*` functions, add vim.env.VIMRUNTIME/lua.
                  -- "${3rd}/luv/library"
                  -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
              }
            }
          })
        end
        return true
      end
    })
  end
})

require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}
cmp.setup({ ---@diagnostic disable-line: missing-fields
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
