local bundle_ruby_lsp = false
local ruby_lsp_cmd = { cmd = { 'ruby-lsp' }, cmd_env = {} }

-- test if 'ruby-lsp' is in the Gemfile.lock, if so use 'bundle exec ruby-lsp', else use 'ruby-lsp' directly
local f = io.open('Gemfile.lock', 'r')
if f then
  for line in f:lines() do
    if line:find('ruby-lsp', 1, true) then bundle_ruby_lsp = true end
  end
  f:close()
else
  -- if no Gemfile.lock, use a global gemfile in home directory to avoid creating a Gemfile.lock in every project
  ruby_lsp_cmd.cmd_env.BUNDLE_GEMFILE = os.getenv('HOME') .. '/.ruby-lsp/Gemfile'
end

if bundle_ruby_lsp then
  table.insert(ruby_lsp_cmd.cmd, 1, 'bundle')
  table.insert(ruby_lsp_cmd.cmd, 2, 'exec')
end

-- finally, use mise if available
ruby_lsp_cmd.cmd = require('drowze.utils').mise_cmd(ruby_lsp_cmd.cmd, { tool = 'ruby' })

local function add_custom_commands(client, bufnr)
  -- Show Ruby dependencies in quickfix list
  local function show_ruby_deps(opts)
    local params = vim.lsp.util.make_text_document_params()
    local showAll = opts.args == "all"

    local function callback(error, result)
      if error then
        print("Error showing deps: " .. error)
        return
      end

      local qf_list = {}
      for _, item in ipairs(result) do
        if showAll or item.dependency then
          table.insert(qf_list, {
            text = string.format("%s (%s) - %s", item.name, item.version, item.dependency),
            filename = item.path
          })
        end
      end

      vim.fn.setqflist(qf_list)
      vim.cmd('copen')
    end

    client:request("rubyLsp/workspace/dependencies", params, callback)
  end

  -- Print installed Ruby LSP addons
  local function show_addons()
    local function callback(error, result)
      if error then
        print("Error displaying addons:\n" .. vim.inspect(error))
        return
      end

      local lines = { "Installed Ruby LSP Addons:" }
      for _, addon in ipairs(result) do
        local line = string.format("%s - %s%s", addon.name, addon.version, addon.errored and " (errored)" or "")
        table.insert(lines, line)
      end
      print(table.concat(lines, "\n"))
    end

    client:request("rubyLsp/workspace/addons", nil, callback)
  end

  -- Show Prism syntax tree for current buffer or selected range in a new split
  local function show_syntax_tree(opts)
    local params
    if opts.range == 2 then
      params = vim.lsp.util.make_given_range_params(
        { opts.line1 - 1, 0 },
        { opts.line2, 0 },
        0,
        client.offset_encoding
      )
    else
      params = vim.lsp.util.make_position_params(0, client.offset_encoding)
    end

    local function callback(error, result)
      if error then
        print("Error showing syntax tree:\n" .. vim.inspect(error))
        return
      end

      local lines = {}
      for line in result.ast:gmatch(("[^\n]+")) do
        table.insert(lines, line)
      end

      vim.cmd('vsplit')
      local win = vim.api.nvim_get_current_win()
      local buf = vim.api.nvim_create_buf(true, true)
      vim.api.nvim_win_set_buf(win, buf)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    end

    client:request("rubyLsp/textDocument/showSyntaxTree", params, callback)
  end

  vim.api.nvim_buf_create_user_command(bufnr, "LspRubyShowDeps", show_ruby_deps, { nargs = "?", complete = function() return { "all" } end })
  vim.api.nvim_buf_create_user_command(bufnr, "LspRubyShowAddons", show_addons, {})
  vim.api.nvim_buf_create_user_command(bufnr, "LspRubyShowSyntaxTree", show_syntax_tree, { range = 2 })
end

-- This command is invoked by the RSpec addon of ruby-lsp to run tests with code lens
vim.lsp.commands['rubyLsp.runTest'] = function(opts)
  require('drowze.utils').run_test_in_split(opts.arguments[3])
end

-- https://github.com/neovim/nvim-lspconfig/blob/v2.5.0/lsp/ruby_lsp.lua
return {
  cmd = ruby_lsp_cmd.cmd,
  cmd_env = ruby_lsp_cmd.cmd_env,
  filetypes = { 'ruby', 'eruby' },
  root_markers = { 'Gemfile.lock', '.git' },
  flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 500,
  },
  -- Reference: https://shopify.github.io/ruby-lsp/editors.html#all-initialization-options
  init_options = {
    addonSettings = {
      ['Ruby LSP Rails'] = {
        enablePendingMigrationsPrompt = false,
      },
      ['Ruby LSP RSpec'] = {
        debug = true,
        rspecCommand = 'bundle exec rspec -f d',
      },
    },
    formatter = 'auto',
    linters = { 'rubocop_internal' },
    experimentalFeaturesEnabled = false,
    enabledFeatures = {
      'codeActions',
      'codeLens',
      'completion',
      'definition',
      'diagnostics',
      'documentHighlights',
      'documentLink',
      'documentSymbols',
      'foldingRanges',
      'formatting',
      'hover',
      'inlayHint',
      'onTypeFormatting',
      'selectionRanges',
      -- 'semanticHighlighting', # leave highlighting to treesitter
      'signatureHelp',
      'typeHierarchy',
      'workspaceSymbol',
    },
    featuresConfiguration = {
      inlayHint = {
        implicitHashValue = true,
        implicitRescue = true,
      },
    },
    indexing = {
      excludedPatterns = {},
      includedPatterns = { '**/spec/**/*.rb' },
      -- excludedMagicComments = { 'compiled:true' },
    },
  },
  on_attach = function(client, buffer)
    add_custom_commands(client, buffer)

    -- maybe also setup an autocmd to refresh codelens. I'm not using codelens currently though
    -- see `setup_refresh_autocmd` at:
    -- https://github.com/adam12/ruby-lsp.nvim/blob/main/lua/ruby-lsp/codelens.lua
  end,
}
