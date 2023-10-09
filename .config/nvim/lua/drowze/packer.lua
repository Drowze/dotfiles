return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  use('wsdjeg/vim-fetch')
  use('towolf/vim-helm')
  use {
    'cuducos/yaml.nvim',
    ft = { 'yaml' },
    requires = { 'nvim-treesitter/nvim-treesitter', 'nvim-telescope/telescope.nvim' }
  }
  use {
    'phelipetls/jsonpath.nvim',
    ft = { 'json' },
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }
  use('pocke/rbs.vim')
  use('Mofiqul/dracula.nvim')
  use('ThePrimeagen/harpoon')
  use('nvim-tree/nvim-web-devicons')
  use { 'norcalli/nvim-colorizer.lua', config = function() require'colorizer'.setup() end }
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    requires = { { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-live-grep-args.nvim' } }
  }
  use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', version = '0.9.0' }
  use('nvim-treesitter/nvim-treesitter-textobjects')
  use { 'nvim-treesitter/playground', opt = true, cmd = 'TSPlayground' }
  use { 'RRethy/nvim-treesitter-endwise', requires = { 'nvim-treesitter/nvim-treesitter' } }
  use('mbbill/undotree')
  use ('lewis6991/gitsigns.nvim')
  use('tpope/vim-fugitive')
  use('tpope/vim-rhubarb')
  use { 'tpope/vim-projectionist', ft = { 'ruby' } }
  use { 'tpope/vim-eunuch', config = function () vim.cmd('cnoreabbrev rename Rename') end }
  use {
    'kylechui/nvim-surround',
    tag = '*',
    config = function() require'nvim-surround'.setup() end,
    event = 'CursorMoved'
  }
  use { 'Wansmer/treesj', requires = { 'nvim-treesitter' }, config = function() require('treesj').setup() end }
  use('vim-test/vim-test')
  use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }

  -- let there be LSP... --
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
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

  -- let there be DAP... --
  use('mfussenegger/nvim-dap')
  use('mfussenegger/nvim-dap-python')
  use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }
end)
