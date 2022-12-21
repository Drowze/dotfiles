return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  use('Mofiqul/dracula.nvim')
  use('ThePrimeagen/harpoon')
  use('nvim-tree/nvim-web-devicons')
  use { 'norcalli/nvim-colorizer.lua', config = function() require'colorizer'.setup() end }
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} } }
  use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use('nvim-treesitter/nvim-treesitter-textobjects')
  use{ 'nvim-treesitter/playground', opt = true, cmd = 'TSPlayground' }
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use { 'tpope/vim-projectionist', ft = { 'ruby' } }
  use { 'kylechui/nvim-surround', tag = '*', config = function() require'nvim-surround'.setup() end, event = 'CursorMoved' }
  use('vim-test/vim-test')

  -- let there be LSP... --
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
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
  }
  -- lsp config for neovim functions
  use('folke/neodev.nvim')

  -- lsp functions for status bar
  use('nvim-lua/lsp-status.nvim')
end)
