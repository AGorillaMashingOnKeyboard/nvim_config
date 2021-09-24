""""""""""""""""""""
" vim-plug
""""""""""""""""""""
call plug#begin('~/AppData/Local/nvim/plugged')

" lsp
Plug 'neovim/nvim-lspconfig'

" language parser
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'David-Kunz/treesitter-unit/'
"Plug 'RRethy/nvim-treesitter-textsubjects'

" git
Plug 'tpope/vim-fugitive'

" file explorer
Plug 'lambdalisue/fern.vim'
Plug 'antoinemadec/FixCursorHold.nvim'    "temporary fix for issue in neovim

" status line
Plug 'shadmansaleh/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" colors
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'

call plug#end()
""""""""""""""""""""

"map <silent> <C-n> :NERDTreeFocus<CR>

" UI {{{
set number      "show line number
set nowrap      "no word wrap
set colorcolumn=80
set scrolloff=5     "always show 5 lines above/below when scrolling
set sidescrolloff=5 "always show 5 lines left/right when scrolling
"set list       "show whitespace
"set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
" }}}

" Spaces and Tabs {{{
set tabstop=4       "number of spaces per tab
set shiftwidth=4    "number of spaces to use for autoindent
set softtabstop=4   "number of spaces per tab when editing
set expandtab       "tabs are spaces
" }}}


" Vim keybinds
let mapleader = ","


" LSP keybinds {{{
" Jump to definition
nnoremap gd <Cmd>lua vim.lsp.buf.definition()<CR>
" Open code actions using the default lsp UI, if you want to change this please see the plugins above
nnoremap ga <Cmd>lua vim.lsp.buf.code_action()<CR>
" }}}


" Treesitter keybinds {{{
xnoremap iu :lua require"treesitter-unit".select()<CR>
xnoremap au :lua require"treesitter-unit".select(true)<CR>
onoremap iu :<c-u>lua require"treesitter-unit".select()<CR>
onoremap au :<c-u>lua require"treesitter-unit".select(true)<CR>
" }}}


" Fix cursor hold config
" in millisecond, used for both CursorHold and CursorHoldI,
" use updatetime instead if not defined
let g:cursorhold_updatetime = 100


" Fern keybinds {{{
let g:fern#disable_default_mappings = 1

noremap <silent> <Leader>f :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> <F2> <Plug>(fern-action-rename)
  nmap <buffer> b <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> <F5> <Plug>(fern-action-reload)
  nmap <buffer> s <Plug>(fern-action-mark:toggle)
  nmap <buffer> H <Plug>(fern-action-hidden:toggle)
  nmap <buffer> <nowait> < <Plug>(fern-action-leave)
  nmap <buffer> <nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernEvents
  autocmd!
  autocmd FileType fern call FernInit()
augroup END
" }}}


" lua configs
lua << EOF

require'lspconfig'.pyright.setup{}
require'lspconfig'.clangd.setup{}

require'nvim-treesitter.install'.compilers = { "cl" }
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"python"},
  highlight = {
    enable = true,
    },
}

require 'lualine'.setup {
  options = {
    icons_enabled = true, 
    theme = 'gruvbox_dark',
    section_separators = '',
    component_separators = '',
    disabled_filetypes = {'fern'}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {'filetype', icon_only = true, padding = {left = 1, right = 0}},
      'filename'
    },
    lualine_c = {'diagnostics'},
    lualine_x = {
      'branch', 
      {
        'diff',
        colored = true,
        diff_color = {
          added = {fg = '#b8bb26'},
          modified = {fg = '#fabd2f'},
          removed = {fg = '#fb4934'},
        },
        symbols = {added = '+', modified = '~', removed = '-'}
      }
    },
    lualine_y = {
      {'encoding', padding = {left = 1, right = 0}}, 
      'location'
    },
    lualine_z = {'progress'}
  }
}

EOF



