return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {  'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-live-grep-args.nvim' },
  opts = {
    defaults = {
      prompt_prefix= "🔍 "
    },
    pickers = {
      buffers = {
        mappings = {
          n = {
            ["dd"] = "delete_buffer",
          }
        }
      }
    }
  },
  config = function(_, opts)
    local telescope = require('telescope')
    telescope.setup(opts)
    telescope.load_extension('live_grep_args')
  end,
  cmd = 'Telescope',
  keys = {
    { '<C-p>', function() require('telescope.builtin').git_files() end,  desc = 'Telescope: git files' },
    { '<leader>pf', function() require('telescope.builtin').find_files() end, desc = 'Telescope: all files' },
    { '<leader>pb', function() require('telescope.builtin').buffers() end,  desc = 'Telescope: all buffers' },
    { '<leader>pl', function() require('telescope.builtin').lsp_references() end, desc = 'Telescope: LSP references' },
    {
      '<leader>ps',
      function()
        local utils = require('drowze.utils')
        local selection = utils.get_visual_selection()
        -- local escaped_selection = utils.rg_escape(selection)
        require('telescope.builtin').grep_string({ search = selection })
      end,
      mode = 'v',
      desc = 'Telescope: grep selection',
    },
    {
      '<leader>ps',
      function()
        local input = vim.fn.input('grep > ')
        if input == "" then return end

        require('telescope.builtin').grep_string({ search = input })
      end,
      desc = 'Telescope: grep'
    },
    {
      '<leader>pS',
      function()
        local utils = require('drowze.utils')
        local current_path = utils.get_current_path()

        local input = vim.fn.input('(' .. current_path .. ') ' .. 'grep > ')
        if input == "" then return end

        input = '"' .. input .. '" ' .. current_path
        require('telescope').extensions.live_grep_args.live_grep_args({ default_text = input })
      end,
      desc = 'Telescope: live grep on currently open directory'
    },
  }
}
