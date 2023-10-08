" plug installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'cohama/lexima.vim'
Plug 'morhetz/gruvbox'
call plug#end()

" colors
set bg=dark
let g:gruvbox_transparent_bg = 1

colorscheme gruvbox

" autocommands
autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE
augroup LoadViewOnVimrc
    au!
    au BufReadPost ~/.vimrc silent! loadview
augroup END
