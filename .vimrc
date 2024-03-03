" Compatibility with foreign systems (e.g.: when copying our vimrc to a remote
" machine)
if $TERM == "xterm"
  set term=xterm-256color
endif

" Fix groovy syntax
" https://github.com/vim/vim/issues/7280
set regexpengine=0

" Force python to use 2 space indentation
function! SetupPython()
  setlocal softtabstop=2
  setlocal tabstop=2
  setlocal shiftwidth=2
endfunction
command! -bar SetupPython call SetupPython()

" Disable arrow keys on normal mode
noremap <LEFT> :echo 'hjkl'<CR>
noremap <UP> :echo 'hjkl'<CR>
noremap <DOWN> :echo 'hjkl'<CR>
noremap <RIGHT> :echo 'hjkl'<CR>

nnoremap <leader>pv :Ex<CR>

" ESC delay wtf check johnhawthorn.com/2012/09/vi-escape-delays
set timeoutlen=1000 ttimeoutlen=0

" Disable help banner on file browser
let g:netrw_banner = 0

" Buggy copy files on macosx
" https://stackoverflow.com/questions/31811335/copying-files-with-vims-netrw-on-mac-os-x-is-broken
let g:netrw_keepdir = 0

" tree view on netrw
let g:netrw_liststyle = 3

" show sign column
set signcolumn=yes

" remap super
let mapleader = " "

" shows 'partial' command
set showcmd

" wraps text correctly
set wrap
set linebreak

" adds padding to scrolling
set scrolloff=4

" do not reset buffers size when closing one
set noequalalways

" keep buffers in memory (i.e. persist undo history)
set hidden

" Toggle pastemode (for pasting without breaking formatting)
set pastetoggle=<F3>

" Select text again after indenting
:vnoremap < <gv
:vnoremap > >gv

" incremental search
set incsearch

" Open split to the right/to below
set splitright
set splitbelow

" Show 'hybrid' line numbers
set number
set relativenumber

" Highlight search results
set hlsearch

" Powerful backspacing
set backspace=indent,eol,start

" Tabs should be 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smartindent

" Show invisible chars
set list
set listchars=tab:▸\ ,eol:↲,trail:·

" Have vimdiff ignoring whitespaces
if exists('&diffopt')
  if has("patch-8.1.0393")
    set diffopt+=iwhiteall
  else
    set diffopt+=iwhite
    function DiffW()
      let opt = ""
       if &diffopt =~ "icase"
         let opt = opt . "-i "
       endif
       if &diffopt =~ "iwhite"
         let opt = opt . "-w "
       endif
       silent execute "!diff -a --binary " . opt .
         \ v:fname_in . " " . v:fname_new .  " > " . v:fname_out
       redraw
    endfunction
    set diffexpr=DiffW()
  endif
endif

" Toggle showing invisible chars
noremap <F12> :set list!<CR>:set noruler!<CR>:highlight EndOfBuffer ctermfg=236<CR>

" Show [ N / Y ] (i.e. current cursor position) when searching
set shortmess-=S

" Cursor shape (tailored for Alacritty I guess)
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

" Zoom / Restore window, like tmux's ctrl-z
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <C-w><C-o> :ZoomToggle<CR>
inoremap <C-w><C-o> <C-o>:ZoomToggle<CR>
tnoremap <C-w><C-o> <C-w>N:ZoomToggle<CR>

" Install vim-plug + plugins if not yet installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugin-injected noteworthy keybindings:
"   vim-windowswap:
"   - `<leader>ww` swap windows
call plug#begin('~/.vim/plugged')
  Plug 'airblade/vim-gitgutter'
  Plug 'ap/vim-css-color'
  Plug 'chrisbra/Colorizer'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'itchyny/lightline.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-slash'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'pangloss/vim-javascript'
  Plug 'posva/vim-vue'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-vinegar'
  Plug 'vim-test/vim-test'
  Plug 'wesQ3/vim-windowswap'
  Plug 'wsdjeg/vim-fetch'
call plug#end()

" custom filetypes. Has to be after plugins for some reason
autocmd BufNewFile,BufRead *.jbuilder setfiletype ruby
autocmd BufNewFile,BufRead *.sc setfiletype scala

" <plugin options section>

" auto-pairs
au FileType ruby let b:AutoPairs = AutoPairsDefine({'begin': 'end//n]'})

" Projectionist
" quickly toggle to spec file with :A (or :AV, :AS, :AT for splits/tabs)
let g:projectionist_heuristics = {
\ 'app/*': {
\   'app/*.rb': { 'alternate': 'spec/{}_spec.rb' },
\   'spec/*_spec.rb': { 'alternate': 'app/{}.rb' }
\ },
\ 'lib/*': {
\   'lib/*.rb': { 'alternate': 'spec/{}_spec.rb' },
\   'spec/*_spec.rb': { 'alternate': 'lib/{}.rb' }
\ }}

" Fzf
nnoremap <C-p> :Files<Cr>
let g:fzf_layout = { 'down': '40%' }

" Fzf+rg
" https://github.com/junegunn/fzf.vim/blob/161da95/README.md#example-advanced-ripgrep-integration
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" lightline
set laststatus=2 " show status bar
set noshowmode " hide mode under status bar
let g:lightline = {
\ 'colorscheme': 'dracula',
\ 'active': {
\   'left': [
\     [ 'mode', 'paste' ],
\     [ 'buffno', 'readonly', 'filename', 'modified' ]
\   ]
\ },
\ 'component': {
\   'buffno': '%1.3n'
\ }}

" vim-test
" custom function to delete buffers instead of minimizing
" TODO: consider changing to
" https://github.com/jonleighton/vim-test-vimterminal-enhanced
function! VimTerminalWithDelete(cmd)
  let term_position = get(g:, 'test#vim#term_position', 'botright')
  execute term_position . ' new'
  call term_start(['/bin/sh', '-c', a:cmd], {'curwin': 1, 'term_name': a:cmd})
  nnoremap <buffer> <Enter> :bd<CR>
  au BufDelete <buffer> wincmd p
  wincmd p
  redraw
  echo "Press <Enter> to exit test runner terminal (<Ctrl-C> first if command is still running)"
endfunction
let g:test#custom_strategies = {'vimterminal_withdelete': function('VimTerminalWithDelete')}
let test#strategy = "vimterminal_withdelete"

let test#vim#term_position = "belowright 10"
nnoremap <Leader>t :TestFile<CR>
nnoremap <Leader>T :TestNearest<CR>
let test#ruby#rspec#options = {
\ 'file': '--order defined',
\ }
" <plugin options section>

" If on doubt, 'syntax on vs enable' @google
if !exists("g:syntax_on")
  syntax enable
endif

let g:dracula_colorterm = 0
color dracula

" Needs to go after colorscheme definition
highlight DraculaComment cterm=italic gui=italic
