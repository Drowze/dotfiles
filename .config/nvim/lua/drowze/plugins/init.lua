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
  { 'NvChad/nvim-colorizer.lua', config = true },
  { 'tpope/vim-fugitive', event = 'VeryLazy' },
  { 'tpope/vim-rhubarb', event = 'VeryLazy', dependencies = 'tpope/vim-fugitive' },
  { 'tpope/vim-eunuch', event = 'VeryLazy', config = function () vim.cmd('cnoreabbrev rename Rename') end },
  {
    'kylechui/nvim-surround',
    version = '*',
    config = true,
    event = 'VeryLazy'
  },
  { 'numToStr/Comment.nvim', config = true },
  {
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    config = { disabled_filetypes = { "netrw", "oil", "tsplayground" }, restriction_mode = "hint" }
  },

  -- let there be LSP... --
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},
      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  },
  -- lsp config for neovim functions
  'folke/neodev.nvim',
}
