require('dracula').setup({
  transparent_bg = true,
  show_end_of_buffer = true,
  italic_comment = true,
})
vim.cmd.colorscheme('dracula')
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = 'white' })
