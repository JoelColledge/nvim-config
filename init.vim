call plug#begin('/opt/jcolledge/packages/nvim-plug')
Plug 'tomasr/molokai'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
call plug#end()

let mapleader = "\<Space>"

colorscheme molokai

set number relativenumber
set title
" set whichwrap=b,s,h,l
set mouse=a
set ignorecase
set inccommand=split
set updatetime=100
nnoremap <Esc><Esc> :nohlsearch<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
