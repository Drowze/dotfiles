return {
  {
    'echasnovski/mini.indentscope',
    version = false,
    event = 'VeryLazy',
    config = true
  },
  {
    'echasnovski/mini.surround',
    version = false,
    event = 'VeryLazy',
    opts = {
      search_method = 'cover_or_nearest',
    }
  },
  -- TODO: investigate screenshots
  -- {
  --   'echasnovski/mini.test',
  --   version = false,
  --   event = 'VeryLazy',
  --   config = true
  -- },

  -- mini.clue should go last to avoid keybind conflicts
  {
    'echasnovski/mini.clue',
    version = false,
    event = 'VeryLazy',
    config = function(_, opts)
      local miniclue = require('mini.clue')

      -- Enhance this by adding descriptions for <Leader> mapping groups
      opts.clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      }
      miniclue.setup(opts)
    end,
    opts = function()
      return {
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- mini.surround
          { mode = 'n', keys = 's' },
          { mode = 'x', keys = 's' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },

          -- '[ and ']'
          { mode = 'n', keys = '[' },
          { mode = 'n', keys = ']' },
        },

        window = {
          -- Floating window config
          config = {},

          -- Delay before showing clue window
          delay = 200,

          -- Keys to scroll inside the clue window
          scroll_down = '<C-d>',
          scroll_up = '<C-u>',
        },
      }
    end,
  },
}

