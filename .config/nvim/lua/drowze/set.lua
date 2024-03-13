vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'

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

-- speeds up dramatically opening python files
vim.g['python3_host_prog'] = '$HOME/.asdf/shims/python3'

local function set_custom_filetype(pattern, filetype)
  vim.api.nvim_create_autocmd(
    { 'BufNewFile', 'BufRead' },
    {
      pattern = pattern,
      callback = function()
        vim.api.nvim_set_option_value('filetype', filetype, { scope = 'local' })
      end
    }
  )
end

set_custom_filetype('*.jbuilder', 'ruby')
set_custom_filetype('Dangerfile', 'ruby')
set_custom_filetype('.pryrc', 'ruby')
