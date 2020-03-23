" TODO: Fix delete behaviour on a MacOS

" Disable arrow keys on normal mode
noremap <LEFT> :echo 'hjkl'<CR>
noremap <UP> :echo 'hjkl'<CR>
noremap <DOWN> :echo 'hjkl'<CR>
noremap <RIGHT> :echo 'hjkl'<CR>

" ESC delay wtf check johnhawthorn.com/2012/09/vi-escape-delays
set timeoutlen=1000 ttimeoutlen=0

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

" Tabs should be spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Show tabs
set list
set listchars=tab:▸\ ,eol:↲,trail:·

" Status line
set laststatus=2
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " flags and buf no
set statusline+=%-40f\                    " path
set statusline+=%=%1*%y%*%*\              " file type
set statusline+=%10((%l,%c)%)\            " line and column
set statusline+=%P                        " percentage of file

call plug#begin('~/.vim/plugged')
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'posva/vim-vue'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'tpope/vim-fugitive'
call plug#end()

" Ignore node_modules on ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" If on doubt, 'syntax on vs enable' @google
if !exists("g:syntax_on")
  syntax enable
endif

let g:dracula_italic = 0
let g:dracula_colorterm = 0
color dracula
