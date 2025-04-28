return {
  'vim-test/vim-test',
  keys = {
    { '<leader>t', vim.cmd.TestFile, desc = 'vim-test: Test file' },
    { '<leader>T', vim.cmd.TestNearest, desc = 'vim-test: Test nearest' }
  },
  config = function()
    -- custom vim-test strategy, derivated from neovim strategy; probably overly complicated but oh well
    -- - disable line numbers
    -- - map enter to delete the buffer, so we can scroll the buffer or press enter to close it
    -- - map ctrl-c to send ctrl-c to the running job, so we can kill the test on normal mode
    -- - when the process finishes (TermClose), unmap ctrl-c to noop (so don't accidentally close the terminal if spam ctrl-c)
    -- - when buffer is deleted (BufDelete) switch back to last window after creating the buffer
    -- - switch back to last window after creating the buffer
    local neovim_enhanced = function (cmd)
      local open_split_cmd = (vim.g['test#neovim#term_position'] or 'botright') .. ' new'
      vim.api.nvim_command(open_split_cmd)
      vim.fn.termopen(cmd)
      vim.api.nvim_set_option_value('number', false, { scope = 'local' })
      vim.api.nvim_set_option_value('relativenumber', false, { scope = 'local' })
      vim.b['miniindentscope_disable'] = true

      vim.keymap.set('n', '<CR>', function() vim.api.nvim_buf_delete(0, {}) end, { buffer = true })

      vim.keymap.set('n', '<C-c>', function()
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('i<C-c><C-\\><C-N>G', true, true, true))
      end, { buffer = true })

      vim.api.nvim_create_autocmd('TermClose', {
        buffer = 0,
        callback = function()
          vim.keymap.set('n', '<C-c>', function()
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('G', true, true, true))
          end, { buffer = true })
        end
      })

      vim.api.nvim_create_autocmd('BufDelete', {
        buffer = 0,
        callback = function() vim.api.nvim_command('wincmd p') end
      })
      vim.api.nvim_command('wincmd p')
    end
    vim.g['test#custom_strategies'] = { neovim_enhanced = neovim_enhanced }

    vim.g['test#strategy'] = 'neovim_enhanced'
    vim.g['test#neovim#term_position'] = 'belowright 15'
    vim.g['test#ruby#rspec#options'] = {
      ['nearest'] = '--no-profile --format documentation --order defined',
      ['file'] = '--no-profile --format documentation',
    }
  end
}
