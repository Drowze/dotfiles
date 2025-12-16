local ts_parsers = {}
local ts_filetypes = {}
for parser, filetypes in pairs({
  -- core parsers:
  ['bash'] = { 'bash', 'sh' },
  ['comment'] = { 'comment' },
  ['css'] = { 'css' },
  ['diff'] = { 'diff', 'gitdiff' },
  ['fish'] = { 'fish' },
  ['git_config'] = { 'git_config', 'gitconfig' },
  ['git_rebase'] = { 'git_rebase', 'gitrebase' },
  ['gitcommit'] = { 'gitcommit' },
  ['gitignore'] = { 'gitignore' },
  ['html'] = { 'html' },
  ['javascript'] = { 'javascript', 'javascriptreact', 'ecma', 'ecmascript', 'jsx', 'js' },
  ['json'] = { 'json' },
  ['latex'] = { 'latex', 'tex' },
  ['lua'] = { 'lua' },
  ['luadoc'] = { 'luadoc' },
  ['make'] = { 'make', 'automake' },
  ['markdown'] = { 'markdown', 'pandoc' },
  ['markdown_inline'] = { 'markdown_inline' },
  ['norg'] = { 'norg' },
  ['python'] = { 'python', 'py', 'gyp' },
  ['query'] = { 'query' },
  ['regex'] = { 'regex' },
  ['scss'] = { 'scss' },
  ['svelte'] = { 'svelte' },
  ['toml'] = { 'toml' },
  ['tsx'] = { 'tsx', 'typescriptreact', 'typescript.tsx' },
  ['typescript'] = { 'typescript', 'ts' },
  ['typst'] = { 'typst', 'typ' },
  ['vim'] = { 'vim' },

  ['vimdoc'] = { 'vimdoc', 'checkhealth', 'help' },
  ['vue'] = { 'vue' },
  ['xml'] = { 'xml', 'xsd', 'xslt', 'svg' },
  -- additional parsers:
  ['ruby'] = { 'ruby' },
}) do
  table.insert(ts_parsers, parser)
  for _, filetype in pairs(filetypes) do
    table.insert(ts_filetypes, filetype)
  end
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufRead',
    build = ':TSUpdate',
    branch = 'main',
    config = function()
      require("nvim-treesitter").install(ts_parsers)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = ts_filetypes,
        callback = function() vim.treesitter.start() end,
      })
    end,
  },
  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- NOTE: lazy loading on keymaps does not work (as treesitter-modules listen to FileType event)
    -- see: https://github.com/MeanderingProgrammer/treesitter-modules.nvim/blob/dcb5030422732af54631083316887e512e4a79a3/lua/treesitter-modules/core/manager.lua
    event = 'BufRead',
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<A-o>",
          node_incremental = "<A-o>",
          scope_incremental = "<A-O>",
          node_decremental = "<A-i>",
        },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    keys = {
      { "am", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end, mode = { 'x', 'o' }, desc = "Select outer block" },
      { "im", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end, mode = { 'x', 'o' }, desc = "Select outer block" },

      { "ab", function() require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects") end, mode = { 'x', 'o' }, desc = "Select outer block" },
      { "ib", function() require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects") end, mode = { 'x', 'o' }, desc = "Select inner block" },

      { "ac", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects") end, mode = { 'x', 'o' }, desc = "Select outer class" },
      { "ic", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects") end, mode = { 'x', 'o' }, desc = "Select inner class" },
    },
    opts = {
      textobjects = {
        select = {
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

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
          -- and should return true of false
          include_surrounding_whitespace = false,
        },
      },
    },
  },
  {
    'RRethy/nvim-treesitter-endwise',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'ruby', 'lua', 'elixir', 'vim', 'bash', 'fish', 'julia' },
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
      --           vim.cmd('SplitjoinJoin') -- depends on AndrewRadev/splitjoin.vim
      --         end,
      --       },
      --     },
      --     class = {
      --       both = {
      --         no_format_with = {},
      --         fallback = function(_)
      --           vim.cmd('SplitjoinSplit')-- depends on AndrewRadev/splitjoin.vim
      --         end,
      --       },
      --     },
      --   },
      -- }
    }
  },
}
