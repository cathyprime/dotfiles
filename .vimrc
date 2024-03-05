let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
        silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

colorscheme habamax
set splitbelow splitright
set nu rnu
set hls
set cursorline
set wildmenu
set scrolloff=8
set showcmd
set shortmess-=S
set notimeout
set laststatus=2
set path=.,**

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
imap <c-s> <Plug>ISurround

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

command! -nargs=? Scratch call Scratch(<q-args>, <q-mods>)
