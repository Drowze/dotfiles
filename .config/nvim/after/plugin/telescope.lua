local builtin
local telescope
local loaded_exts = false

local function lazy_telescope(opts)
  opts = opts or {}

  if not telescope then telescope = require'telescope' end
  if opts.load_ext and not loaded_exts then
    loaded_exts = true
    telescope.load_extension('live_grep_args')
  end

  return telescope
end

local function lazy_builtin()
  if not builtin then
    builtin = require'telescope.builtin'
  end
  return builtin
end
vim.keymap.set('n', '<C-p>', function() lazy_builtin().git_files() end, { desc = 'Telescope: git files' })
vim.keymap.set('n', '<leader>pf', ":lua require('telescope.builtin').find_files()<CR>", { desc = 'Telescope: all files' })
vim.keymap.set('n', '<leader>pl', ":lua require('telescope.builtin').lsp_references()<CR>", { desc = 'Telescope: LSP references' })

vim.keymap.set('n', '<leader>ps', function()
  local input = vim.fn.input('Grep > ')
  require('telescope.builtin').grep_string({ search = input })
end, { desc = 'Telescope: grep' })

vim.keymap.set('n', '<leader>pS', function()
  lazy_telescope({ load_ext = true }).extensions.live_grep_args.live_grep_args()
end, { desc = 'Telescope: live grep' })
