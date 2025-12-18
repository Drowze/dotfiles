-- vim options remaps independent of installed plugins
require('drowze.remap')
require('drowze.set')
require('drowze.lsp')

-- bootstrap and setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)
require('lazy').setup({
  ui = { border = 'rounded' },
  change_detection = { enabled = false }, -- don't bother me when tweaking config
  rocks = { enabled = false }, -- none of my plugins use luarocks
  spec = 'drowze.plugins',
  performance = {
    rtp = {
      -- Stuff I don't use.
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'rplugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

vim.cmd('runtime macros/matchit.vim')
