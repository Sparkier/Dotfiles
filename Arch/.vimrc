" =============================================================================
" {{{ BASIC SETTINGS
" =============================================================================
set nocompatible

filetype on
filetype plugin on
filetype indent on

" ######## SYNTAX #############################################################
syntax enable
set background=dark

" ######## ENCODING ###########################################################
set encoding=utf8
set termencoding=utf-8
set fileencoding=utf-8

" ######## LINE NUMBERS #######################################################
" Line numbers
set number

" ######## FORMAT #############################################################
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
" copy the indention from prev line
set autoindent
" auto indent in some files e.g. C-like
set smartindent
" wrapping words
set formatoptions+=t
" no new line after 80 chars
set textwidth=0
" wrap long lines - only for display, no new lines!
set linebreak
set wrap
" wrap 5 chars before right window border
set wrapmargin=5
" Tab-stuff
set expandtab
set smarttab
" smart backspace
set backspace=indent,eol,start

" ######## SEARCH #############################################################
" instant regex preview
set incsearch
" show all search results
set hlsearch
" turn off wrapping while searching
set nowrapscan
" tolle regex
set magic
" better search
set smartcase
set ignorecase

" ######## VISUAL #############################################################
" Don't redraw while executing macros (good performance config)
set lazyredraw
" show matching brackets
set showmatch
" graphical menu for command mode autocomplete
set wildmenu
" min 5 lines at top and bottom
set scrolloff=5
" set antialias
set antialias
" use tabs
set switchbuf=usetab
" make Vim run moar smooth
set ttyfast
" mouse in all modes
set mouse=a
" cursor-zeile markieren
set cursorline
" fixing delay on leaving insert-mode
set notimeout
set ttimeout
set ttimeoutlen=10

" ######## LANG ###############################################################
set spelllang=de,en

" ######## FILESYSTEM #########################################################
" fu swapfiles
set noswapfile
set nobackup
" auto read file when a file is changed from outside
set autoread
" normal OS clipboard interaction
set clipboard=unnamedplus

" ######## KEYBINDINGS ########################################################
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
" save on double esc
map <Esc><Esc> :w<CR>
" Y for yank until last non whitespace char, like D
nnoremap Y yg_
" Create newlines without entering insert mode
nnoremap go o<Esc>k
nnoremap gO O<Esc>j
" save as sudo
cabbrev w!! w !sudo tee % > /dev/null %
" source vimrc
cabbrev so :source ~/.vimrc
" turn off hightlighting on backspace
nnoremap <silent> <bs> :nohl<cr>
" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>mwgk:silent! s/\v +$//<cr>:noh<cr>`w
nnoremap gS a<cr><esc>mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" ######## UNDO ##############################################################
set undofile
" maximum number of changes that can be undone
set undolevels=1000
" maximum number lines to save for undo on a buffer reload
set undoreload=10000
set undodir=~/.vim/undodir//
set viminfo+=n~/.vim/viminfo

" =============================================================================
" {{{ MY BUNDELS
" =============================================================================

" install plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

" toggle Cursor
Plug 'jszakmeister/vim-togglecursor'

" Vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" auto close brackets

Plug 'raimondi/delimitmate'

" COLORSCHEMES
" base 16 colorscheme
Plug 'chriskempson/base16-vim'
" Tomorrow
Plug 'chriskempson/vim-tomorrow-theme'
" solarized
Plug 'altercation/vim-colors-solarized'

call plug#end()
" }}}

" ######## COLORSCHEME #########################################################
colorscheme Tomorrow-Night

