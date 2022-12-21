vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'

-- show partial command
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

-- we use undotree and have a ~permanent~ history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true