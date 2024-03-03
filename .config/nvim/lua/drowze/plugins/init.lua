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
    config = { disabled_filetypes = { "netrw", "oil", "tsplayground" }, restriction_mode = "hint", disable_mouse = false }
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  -- lsp:
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason-lspconfig.nvim", dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" } },
  { "williamboman/mason.nvim" },
  { 'L3MON4D3/LuaSnip' }, -- snippets
  { 'folke/neodev.nvim' }, -- lsp config for neovim functions
  { 'hrsh7th/cmp-nvim-lsp', dependencies = { 'hrsh7th/nvim-cmp' } }, -- autocomplete (lsp)
  { 'hrsh7th/cmp-nvim-lua' }, -- autocomplete (lsp)
  { 'hrsh7th/nvim-cmp' }, -- autocomplete engine
  { 'saadparwaiz1/cmp_luasnip' }, -- autocomplete lua thru luasnip (is needed, considering neodev?)
}
