return {
  'wsdjeg/vim-fetch',
  { 'towolf/vim-helm', ft = 'helm' },
  {
    'cuducos/yaml.nvim',
    ft = { 'yaml' },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-telescope/telescope.nvim' }
  },
  {
    'phelipetls/jsonpath.nvim',
    ft = { 'json' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' }
  },
  { 'pocke/rbs.vim', ft = { 'rbs'} },
  { 'NvChad/nvim-colorizer.lua', opts = { user_default_options = { names = false } } },
  { 'tpope/vim-fugitive', event = 'VeryLazy' },
  { 'tpope/vim-rhubarb', event = 'VeryLazy', dependencies = 'tpope/vim-fugitive' },
  { 'tpope/vim-eunuch', event = 'VeryLazy', config = function () vim.cmd('cnoreabbrev rename Rename') end },
  {
    'kylechui/nvim-surround',
    version = '*',
    config = true,
    event = 'VeryLazy'
  },
  { 'klen/nvim-config-local', opts = { lookup_parents = true } },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },
  { 'tyru/capture.vim', cmd = 'Capture' },
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {},
    keys = {
      { "<leader>gly", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
      { "<leader>glo", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
    },
  },
  { "LunarVim/bigfile.nvim", ft = { "javascript", "json", "html", "css" } },
  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function() require('mini.indentscope').setup() end
  },

  -- lsp:
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason-lspconfig.nvim", dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" } },
  { "williamboman/mason.nvim" },
  { 'L3MON4D3/LuaSnip' }, -- snippets
  { 'hrsh7th/cmp-nvim-lsp', dependencies = { 'hrsh7th/nvim-cmp' } }, -- autocomplete (lsp)
  { 'hrsh7th/cmp-nvim-lua' }, -- autocomplete (lsp)
  { 'hrsh7th/nvim-cmp' }, -- autocomplete engine
  { 'saadparwaiz1/cmp_luasnip' }, -- autocomplete lua thru luasnip (is needed, considering neodev?)
}
