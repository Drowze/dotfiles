" Fix groovy syntax
" https://github.com/vim/vim/issues/7280
set regexpengine=0

" Disable arrow keys on normal mode
noremap <LEFT> :echo 'hjkl'<CR>
noremap <UP> :echo 'hjkl'<CR>
noremap <DOWN> :echo 'hjkl'<CR>
noremap <RIGHT> :echo 'hjkl'<CR>

" ESC delay wtf check johnhawthorn.com/2012/09/vi-escape-delays
set timeoutlen=1000 ttimeoutlen=0

" Toggle listchars
noremap <F12> :set list!<CR>

" Toggle pastemode (for pasting without breaking formatting)
inoremap <F3> <esc>:set paste!<cr>i
nnoremap <F3> :set paste!<cr>

" Select text again after indenting
:vnoremap < <gv
:vnoremap > >gv

" Show line numbers
set number
set relativenumber

" Show ruler
set colorcolumn=80

" Highlight search results
set hlsearch

" Powerful backspacing
set backspace=indent,eol,start

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

" Show [ N / Y ] (i.e. current cursor position) when searching
set shortmess-=S

" Use rg for grepping
set grepprg=rg\ --vimgrep
set grepformat^=%f:%l:%c:%m

" Fzf
nnoremap <C-p> :Files<Cr>
let g:fzf_layout = { 'down': '40%' }

" vim-test
let test#strategy = "vimterminal"
let test#vim#term_position = "belowright 10"
map <Leader>t :TestFile<CR>

" Cursor shape
" Insert - 5 - blinking vertical bar
" Replace - 4 - solid underscore
" Normal - 2 - solid block
if has('unix')
  let &t_SI = "\<Esc>[5 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
elseif has('mac') " abuse tmux escape sequences
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=5\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=4\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
end

" Install vim-plug + plugins if not yet installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! SetupPython()
  setlocal softtabstop=2
  setlocal tabstop=2
  setlocal shiftwidth=2
endfunction
command! -bar SetupPython call SetupPython()

call plug#begin('~/.vim/plugged')
  Plug 'ap/vim-css-color'
  Plug 'pangloss/vim-javascript'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'posva/vim-vue'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'vim-test/vim-test'
  Plug 'junegunn/vim-slash'
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

" Needs to go after colorscheme definition
highlight Comment cterm=italic
