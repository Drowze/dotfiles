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
    vim.g['test#custom_strategies'] = { neovim_enhanced = require('drowze.utils').run_test_in_split }

    vim.g['test#strategy'] = 'neovim_enhanced'
    vim.g['test#neovim#term_position'] = 'belowright 15'
    vim.g['test#ruby#rspec#options'] = {
      ['nearest'] = '--no-profile --format documentation --order defined',
      ['file'] = '--no-profile --format documentation',
    }
  end
}
