return {
  'wsdjeg/vim-fetch',
  { 'towolf/vim-helm', ft = 'helm' },
  {
    'https://tangled.org/cuducos.me/yaml.nvim',
    ft = { 'yaml' },
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function(opts) require('yaml_nvim').setup(opts) end
  },
  {
    'phelipetls/jsonpath.nvim',
    ft = { 'json' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      local jsonpath = require('jsonpath')
      vim.api.nvim_create_user_command('JSONView', function() vim.print(jsonpath.get()) end, {})
    end
  },
  { 'pocke/rbs.vim', ft = { 'rbs'} },
  { 'NvChad/nvim-colorizer.lua', opts = { user_default_options = { names = false } } },
  { 'tpope/vim-fugitive', event = 'VeryLazy' },
  { 'tpope/vim-rhubarb', event = 'VeryLazy', dependencies = 'tpope/vim-fugitive' },
  { 'tpope/vim-eunuch', event = 'VeryLazy', config = function () vim.cmd('cnoreabbrev rename Rename') end },
  { 'klen/nvim-config-local', opts = { lookup_parents = true, silent = true } },
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {},
    keys = {
      { "<leader>gly", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "gitlinker: Yank git link" },
      { "<leader>glo", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "gitlinker: Open git link" },
      { "<leader>glY", "<cmd>GitLink default_branch<cr>", mode = { "n", "v" }, desc = "gitlinker: Yank git link (default branch)" },
      { "<leader>glO", "<cmd>GitLink! default_branch<cr>", mode = { "n", "v" }, desc = "gitlinker: Open git link (default branch)" },
    },
  },
  { "LunarVim/bigfile.nvim", ft = { "javascript", "json", "html", "css" } },

  {
    "kndndrj/nvim-dbee",
    dependencies = { "MunifTanjim/nui.nvim" },
    build = function() require("dbee").install() end,
    config = true,
    cmd = "Dbee",
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown' },
    opts = {},
  },
  {
    'rachartier/tiny-code-action.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'LspAttach',
    opts = {
      picker = { "buffer", opts = { auto_preview = true } },
    },
  },
}
