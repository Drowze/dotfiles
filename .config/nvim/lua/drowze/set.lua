vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250

-- Built-in fuzzy completion (e.g. buffer names, vim commands, etc)
vim.opt.wildoptions:append { 'fuzzy' }

-- vimdiff: ignore whitespaces, better line-match
-- see neovim/neovim#14537 for more about line-match
vim.opt.diffopt:append { 'iwhiteall', 'linematch:50' }

-- hide current mode, show partial command
vim.opt.showmode = false
vim.opt.showcmd = true

-- decent wrapping/scrolling
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.scrolloff = 4

-- buffer management
vim.opt.equalalways = false
vim.opt.hidden = true
vim.opt.splitright = true
vim.opt.splitbelow = true

-- ruler/line no
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = '80'

-- search
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- tabs/indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- folds
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = false -- do not fold by default

-- invisible characters
vim.opt.list = true
vim.opt.listchars = {
  tab = '▸ ',
  eol = '↲',
  trail= '·'
}

vim.opt.mouse = 'n'

-- we use undotree and have a ~permanent~ history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

-- disable netrw
vim.g['loaded_netrwPlugin'] = 1

-- opens netrw previews (`p`) vertically
vim.g['netrw_preview'] = 1

-- when a vertical preview window is opened, the directory listing
-- will use only 30% of the columns available; the rest of the window
-- is used for the preview window
vim.g['netrw_winsize'] = 30

local api = vim.api

api.nvim_create_user_command(
  'RestartSession',
  ':mksession! /tmp/nvim-session.vim | restart +qa source /tmp/nvim-session.vim',
  { desc = 'Restart neovim and restore current session' }
)

api.nvim_create_user_command(
  'Inspect',
  ':lua print(vim.inspect(<args>))',
  { nargs = 1, complete = 'lua', desc = 'Run and inspect the return of some Lua code' }
)

api.nvim_create_user_command(
  'Messages',
  ":vnew | put =execute('messages') | setlocal buftype=nofile bufhidden=wipe noswapfile",
  { desc = 'Open a new tab with the output of :messages' }
)

vim.filetype.add({ 
  extension = {
    jbuilder = 'ruby',
    pryrc = 'ruby',
    simplecov = 'ruby',
    gemfile = 'ruby',
  },
  filename = {
    Dangerfile = 'ruby',
    Appraisals = 'ruby',
    -- Custom dotenv filetype, so we can disable LSP on such files and maintain tree-sitter highlighting
    ['.env'] = 'sh.dotenv',
    ['.env.test'] = 'sh.dotenv',
    ['.env.development'] = 'sh.dotenv',
    ['.env.production'] = 'sh.dotenv',
    ['.env.local'] = 'sh.dotenv',
    ['.env.development.local'] = 'sh.dotenv',
    ['.env.test.local'] = 'sh.dotenv',
  },
  pattern = {
    -- Custom filetype for GitHub Actions workflows, so we can use a separate LSP
    [".*/%.github/workflows/.*%.ya?ml"] = "yaml.ghactions",
  }
})
