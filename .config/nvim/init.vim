" Disable arrow keys
noremap <LEFT> :echo 'hjkl'
noremap <UP> :echo 'hjkl'
noremap <DOWN> :echo 'hjkl'
noremap <RIGHT> :echo 'hjkl'

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
set listchars=tab:▸\ ,eol:¬

call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'dracula/vim'
call plug#end()

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" Theme options
" set termguicolors
color dracula
