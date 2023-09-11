local builtin
local telescope
local loaded_exts = false

local function lazy_telescope(opts)
  opts = opts or {}

  if not telescope then
    telescope = require'telescope'
    telescope.setup {
      pickers = {
        buffers = {
          mappings = {
            i = {
              ["<c-x>"] = "delete_buffer",
            }
          }
        }
      }
    }
  end
  if opts.load_ext and not loaded_exts then
    loaded_exts = true
    telescope.load_extension('live_grep_args')
  end

  return telescope
end

local function lazy_builtin()
  if not builtin then
    lazy_telescope()
    builtin = require'telescope.builtin'
  end
  return builtin
end

vim.keymap.set('n', '<C-p>', function() lazy_builtin().git_files() end, { desc = 'Telescope: git files' })
vim.keymap.set('n', '<leader>pf', function() lazy_builtin().find_files() end, { desc = 'Telescope: all files' })
vim.keymap.set('n', '<leader>pb', function() lazy_builtin().buffers() end, { desc = 'Telescope: all buffers' })
vim.keymap.set('n', '<leader>pl', function() lazy_builtin().lsp_references() end, { desc = 'Telescope: LSP references' })

vim.keymap.set('n', '<leader>ps', function()
  local input = vim.fn.input('grep > ')
  if input == "" then return end

  lazy_builtin().grep_string({ search = input })
end, { desc = 'Telescope: grep' })

vim.keymap.set('n', '<leader>pS', function()
  local current_path

  if vim.api.nvim_buf_get_option(0, "filetype") == "netrw" then
    -- not using netrw? maybe try current_path = vim.fn.expand('%')
    current_path = vim.b.netrw_curdir
  else
    current_path = vim.fn.expand('%:h')
  end

  -- try to get a relative path
  current_path = vim.fn.fnamemodify(current_path, ":.")

  local input = vim.fn.input('(' .. current_path .. ') ' .. 'grep > ')
  if input == "" then return end

  input = '"' .. input .. '" ' .. current_path
  lazy_telescope({ load_ext = true }).extensions.live_grep_args.live_grep_args({ default_text = input })
end, { desc = 'Telescope: live grep on currently open directory' })
