return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function gitsigns_map(mode, key, action, desc, opts)
        opts = opts or {}
        opts.buffer = bufnr
        if desc then
          opts.desc = 'Gitsigns: ' .. desc
        end
        vim.keymap.set(mode, key, action, opts)
      end

      -- Navigation
      gitsigns_map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gitsigns.next_hunk() end)
        return '<Ignore>'
      end, 'go to next hunk', { expr=true })

      gitsigns_map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gitsigns.prev_hunk() end)
        return '<Ignore>'
      end, 'go to previous hunk', { expr=true })

      -- Actions
      gitsigns_map('n', '<leader>hs', gitsigns.stage_hunk, 'stage hunk')
      gitsigns_map('n', '<leader>hr', gitsigns.reset_hunk, 'reset hunk')
      gitsigns_map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, 'stage hunk')
      gitsigns_map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, 'reset hunk')
      gitsigns_map('n', '<leader>hS', gitsigns.stage_buffer, 'stage buffer')
      gitsigns_map('n', '<leader>hu', gitsigns.undo_stage_hunk, 'undo stage hunk')
      gitsigns_map('n', '<leader>hR', gitsigns.reset_buffer, 'reset buffer')
      gitsigns_map('n', '<leader>hp', gitsigns.preview_hunk, 'preview hunk')
      gitsigns_map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, 'blame line')
      gitsigns_map('n', '<leader>tb', gitsigns.toggle_current_line_blame, 'toggle blame current line')
      gitsigns_map('n', '<leader>hd', gitsigns.diffthis, 'open diff')
      gitsigns_map('n', '<leader>hD', function() gitsigns.diffthis('~') end, 'open diff ~')
      gitsigns_map('n', '<leader>td', gitsigns.toggle_deleted, 'toggle show deleted')

      -- Text object
      gitsigns_map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
  }
}
