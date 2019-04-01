if exists('veonim')

set guifont=DejaVu\ Sans\ Mono:h16
" set guifont=Monospace\ Regular:h22

" built-in plugin manager
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'

" extensions
let g:vscode_extensions = [
  \'vscode.markdown-language-features',
\]

" multiple nvim instances
nno <silent> <c-t>c :Veonim vim-create<cr>
nno <silent> <c-g> :Veonim vim-switch<cr>
nno <silent> <c-t>, :Veonim vim-rename<cr>

" workspace functions
nno <silent> ,f :Veonim files<cr>
nno <silent> ,e :Veonim explorer<cr>
nno <silent> ,b :Veonim buffers<cr>
nno <silent> ,d :Veonim change-dir<cr>
"or with a starting dir: nno <silent> ,d :Veonim change-dir ~/proj<cr>

" searching text
nno <silent> <space>fw :Veonim grep-word<cr>
vno <silent> <space>fw :Veonim grep-selection<cr>
nno <silent> <space>fa :Veonim grep<cr>
nno <silent> <space>ff :Veonim grep-resume<cr>
nno <silent> <space>fb :Veonim buffer-search<cr>

" language features
nno <silent> sr :Veonim rename<cr>
nno <silent> sd :Veonim definition<cr>
nno <silent> si :Veonim implementation<cr>
nno <silent> st :Veonim type-definition<cr>
nno <silent> sf :Veonim references<cr>
nno <silent> sh :Veonim hover<cr>
nno <silent> sl :Veonim symbols<cr>
nno <silent> so :Veonim workspace-symbols<cr>
nno <silent> sq :Veonim code-action<cr>
nno <silent> sk :Veonim highlight<cr>
nno <silent> sK :Veonim highlight-clear<cr>
nno <silent> ,n :Veonim next-usage<cr>
nno <silent> ,p :Veonim prev-usage<cr>
nno <silent> sp :Veonim show-problem<cr>
nno <silent> <c-n> :Veonim next-problem<cr>
nno <silent> <c-p> :Veonim prev-problem<cr>

endif


" Gonvim stuff
let $XDG_CONFIG_HOME = expand($HOME.'/.config')
let $XDG_DATA_HOME = expand($HOME.'/.local/share')
let $XDG_CACHE_HOME  = expand($HOME.'/.cache')

" ʕ◔ϖ◔ʔ Define dein repo path
let s:dein_dir = expand($XDG_CACHE_HOME) . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" ʕ◔ϖ◔ʔ Clone dein.vim repository if it's not exits.
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" ʕ◔ϖ◔ʔ Add the dein installation directory into runtimepath
let &runtimepath = s:dein_repo_dir .",". &runtimepath
let g:dein#install_process_timeout = 9600

if dein#load_state(expand(s:dein_dir))
  call dein#begin(expand(s:dein_dir))

  call dein#add('Shougo/dein.vim')
  if exists('g:gonvim_running')
    call dein#add('akiyosi/gonvim-fuzzy')
  endif
  call dein#add('rafi/awesome-vim-colorschemes')
  call dein#add('BarretRen/vim-colorscheme')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('neoclide/coc.nvim', {'name': 'coc'})

  " ʕ◔ϖ◔ʔ Define dein toml file
  let s:toml_dir  = expand($XDG_CONFIG_HOME) . '/nvim'
  let s:toml_file = s:toml_dir . '/dein.toml'
  call dein#load_toml(s:toml_file, {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif

" ʕ◔ϖ◔ʔ Installation check
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

let mapleader = "\<Space>"

" ʕ◔ϖ◔ʔ Gonvim setting
if exists('g:gonvim_running')
  " ʕ◔ϖ◔ʔ Use Gonvim UI instead of vim native UII
  set laststatus=0
  set noshowmode
  set noruler

  " ʕ◔ϖ◔ʔ I use `ripgrep` for :GonvimFuzzyAg
  let g:gonvim_fuzzy_ag_cmd = 'rg --column --line-number --no-heading --color never'

  " ʕ◔ϖ◔ʔ Mapping for gonvim-fuzzy
  nnoremap <leader><leader> :GonvimWorkspaceNew<CR>
  nnoremap <leader>n :GonvimWorkspaceNext<CR>
  nnoremap <leader>p :GonvimWorkspacePrevious<CR>
  nnoremap <leader>ff :GonvimFuzzyFiles<CR>
  nnoremap <leader>fg :GonvimFuzzyAg<CR>
  nnoremap <leader>fb :GonvimFuzzyBuffers<CR>
  nnoremap <leader>fl :GonvimFuzzyBLines<CR>
endif


" personal config
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
