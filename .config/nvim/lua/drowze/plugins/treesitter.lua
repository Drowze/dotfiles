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
      max_join_length = 240
    }
  },
}
