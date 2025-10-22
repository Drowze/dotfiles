return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'master',
    event = 'BufRead',
    opts = {
      -- A list of parser names, or 'all'
      ensure_installed = { 'vim', 'vimdoc', 'ruby', 'javascript', 'c', 'lua', 'rust', 'python' },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        -- additional_vim_regex_highlighting = { 'ruby' }
        additional_vim_regex_highlighting = false,
      },
    },
    main = 'nvim-treesitter.configs',
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    ft = { 'ruby' },
    main = 'nvim-treesitter.configs',
    keys = {
      { "[C", function() require("treesitter-context").go_to_context(vim.v.count1) end, desc = "Go to previous context" },
    },
    opts = {
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            ["am"] = { query = "@function.outer", desc = "Select outer function/method" }, -- outer function
            ["im"] = { query = "@function.inner", desc = "Select inner function/method" }, -- inner function

            ["ab"] = { query = "@block.outer", desc = "Select outer block" }, -- outer block
            ["ib"] = { query = "@block.inner", desc = "Select inner block" }, -- inner block

            ["ac"] = { query = "@class.outer", desc = "Select outer class" }, -- outer class
            ["ic"] = { query = "@class.inner", desc = "Select inner class" }, -- inner class
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@function.outer'] = 'V', -- linewise
            ['@function.inner'] = 'V', -- linewise
            ['@parameter.outer'] = 'v', -- charwise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true or false
          include_surrounding_whitespace = true,
        },
      },
    }
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
      multiwindow = false, -- Enable multiwindow support.
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    }
  },
  { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle', dependencies = 'nvim-treesitter/nvim-treesitter' },
  {
    'RRethy/nvim-treesitter-endwise',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'ruby', 'lua', 'elixir', 'vim', 'bash', 'fish', 'julia' },
    opts = {
      endwise = { enable = true },
    },
    main = 'nvim-treesitter.configs',
  },
  {
    'Wansmer/treesj',
    keys = {
      { '<space>m', desc = 'treesj: Toggle join' },
      { '<space>j', desc = 'treesj: Join lines' },
      { '<space>s', desc = 'treesj: Split lines' },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      max_join_length = 240,
      -- TODO: figure out how to split/join ruby nested modules
      -- langs = {
      --   ruby = {
      --     module = {
      --       both = {
      --         no_format_with = {}, -- Need to avoid 'no format with comment'
      --         fallback = function(_)
      --           vim.cmd('SplitjoinJoin')
      --         end,
      --       },
      --     },
      --     class = {
      --       both = {
      --         no_format_with = {},
      --         fallback = function(_)
      --           vim.cmd('SplitjoinSplit')
      --         end,
      --       },
      --     },
      --   },
      -- }
    }
  },
}
