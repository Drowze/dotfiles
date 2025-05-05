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
--  { 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = 'nvim-treesitter/nvim-treesitter' },
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
