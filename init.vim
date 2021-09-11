set nocompatible
filetype off

" vim-plug
call plug#begin('~/AppData/Local/nvim/plugged')

" general 
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

" colors
Plug 'morhetz/gruvbox'

" Initialize plugin system
call plug#end()


map <silent> <C-n> :NERDTreeFocus<CR>
