-- NOTE: this plugin handles calling `vim.treesitter.start()` on files with installed parsers

-- vim.treesitter.start() automatically disables regex-based syntax highlighting,
-- which is required for some ftplugins (especially for indentation).
-- This autocmd forces loading regex-based syntax highlighting.
-- See: `:help vim.treesitter.start()`
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ruby',
  callback = function(args)
    -- on vim.schedule to guarantee execution AFTER tree-sitter-manager FileType autocmd
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.bo[args.buf].syntax = 'ON' -- uppercase does matter, see `:help 'syntax'`
      end
    end)
  end,
  desc = 'Enable regex-based syntax highlighting after vim.treesitter.start() disables it',
})

return {
  'romus204/tree-sitter-manager.nvim',
  config = function(_, options)
    require('tree-sitter-manager').setup(options)
  end,
  opts = {
    parser_dir = vim.fn.stdpath("data") .. "/site/parser",
    query_dir = vim.fn.stdpath("data") .. "/site/queries",
    assume_installed = {}, -- blacklist languages
    ensure_installed = {
      'bash',
      'css',
      'fish',
      'git_rebase',
      'gitcommit',
      'hcl',
      'helm',
      'html',
      'javascript',
      'json',
      'lua',
      'markdown',
      'python',
      'ruby',
      'terraform',
      'tmux',
      'toml',
      'typescript',
      'vim',
      'xml',
      'yaml',
    },
    border = "rounded", -- border style for the TUI window
    auto_install = false, -- auto-install when a new filetype is encountered
    noauto_install = {}, -- blacklist from auto_install
    highlight = true, -- enable treesitter highlighting (use list to whitelist)
    nohighlight = {}, -- blacklist from highlight
    languages = {}, -- override or add new parser sources
    nerdfont = true, -- use Nerd Font icons in the manager UI
  }
}
