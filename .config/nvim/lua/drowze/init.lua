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
  change_detection = { enabled = false },
  spec = 'drowze.plugins'
})
--vim.cmd.colorscheme('dracula')
--vim.api.nvim_set_hl(0, 'WinSeparator', { fg = 'white' })

require('drowze.remap')
require('drowze.set')
require('drowze.lsp')

vim.cmd('runtime macros/matchit.vim')
