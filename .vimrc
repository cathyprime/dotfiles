let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
        silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

colorscheme evening
set splitbelow splitright
set nu rnu
set hidden
set wildmenu
set scrolloff=8
set showcmd showmode
set undofile undodir=$HOME/.vim/undo
set pumheight=8
set shortmess-=S shortmess+=c
set notimeout
set laststatus=2
set path=.,**
set tabstop=4 shiftwidth=4 autoindent smartindent
set wrap textwidth=100
set ignorecase smartcase incsearch hls is
set cursorline guicursor=i-ci-ve:block
set termguicolors

let mapleader = " "

call plug#begin()
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
call plug#end()

nnoremap <silent> <c-l> :exec 'noh \| redraw! \| diffupdate!'<cr>
nnoremap <silent> <leader>oc :e ~/.vimrc<cr>
nnoremap <silent> <leader>ob :e ~/.bashrc<cr>

nmap s <plug>Ysurround
nmap S <plug>YSurround
nmap ss <plug>Yssurround
nmap SS <plug>YSsurround
xmap s <plug>VSurround
xmap S <plug>VgSurround
imap <c-s> <plug>ISurround

function! Scratch(ft, mods)
        let old_ft = &filetype
        exec a:mods . " split | enew"
        setlocal buftype=nofile
        setlocal bufhidden=hide
        setlocal noswapfile
        let new_ft = empty(a:ft) ? old_ft : a:ft
        let cmd = 'set ft=' . new_ft
        exec l:cmd
endfunction

nnoremap <expr> k (v:count > 1 ? "m'" . v:count : "") . "k"
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : "") . "j"

command! -nargs=? Scratch call Scratch(<q-args>, <q-mods>)
nnoremap <silent> <leader>os :<c-u>Scratch sh<cr>
