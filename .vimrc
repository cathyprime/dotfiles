" plug installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" options
syntax on
set scrolloff=4
set number
set relativenumber
	" indentation
set tabstop=4
set expandtab
set smartindent
set shiftwidth=4
    " find files
set path+=**
set wildmenu
    " highlighting
set smartcase
set incsearch
set hls
set is
    " splits
set splitright
set splitbelow
set shortmess+=c
    " cursor
set cursorline
set guicursor = "i-ci-ve:block"
    " undo
set undofile
set undodir=~/.vim/undo/

" keybinds
let mapleader = " "

nnoremap <leader>p "+p
nnoremap <leader>P "+P

nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz

nnoremap <c-f> <Nop>
nnoremap <c-b> <Nop>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap <silent> <c-l> :noh<cr>
inoremap <silent> <c-l> <esc>:noh<cr>a

nnoremap J mzJ`z

" plugins
call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'rstacruz/vim-closer'
Plug 'morhetz/gruvbox'
call plug#end()

" colors
set bg=dark
let g:gruvbox_transparent_bg = 1

colorscheme gruvbox

" autocommands
augroup LoadViewOnVimrc
    au!
    au BufReadPost ~/.vimrc silent! loadview
augroup END
