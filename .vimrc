" Disable arrow keys on normal mode
noremap <LEFT> :echo 'hjkl'<CR>
noremap <UP> :echo 'hjkl'<CR>
noremap <DOWN> :echo 'hjkl'<CR>
noremap <RIGHT> :echo 'hjkl'<CR>

" Toggle listchars
noremap <F12> :set list!<CR>

" Select text again after indenting
:vnoremap < <gv
:vnoremap > >gv

" Show line numbers
set number
set relativenumber

" Show ruler
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Tabs should be spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Show tabs
set list
set listchars=tab:▸\ ,eol:↲,trail:·

call plug#begin('~/.config/nvim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" Ignore node_modules on ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Theme options
" set termguicolors
set t_Co=256
syntax enable
color dracula
