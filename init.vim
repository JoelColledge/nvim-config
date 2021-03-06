call plug#begin('/opt/jcolledge/packages/nvim-plug')
Plug 'tomasr/molokai' " color scheme
Plug 'inkarkat/vim-ingo-library' " library for inkarkat's plugins
Plug 'inkarkat/vim-mark' " multiple highlights
Plug 'tpope/vim-abolish' " replace preserving case
Plug 'bkad/CamelCaseMotion' " motion in camel and snake case words
Plug 'itchyny/lightline.vim' " status bar
Plug 'majutsushi/tagbar' " for showing function name in status bar
Plug 'airblade/vim-gitgutter' " git markings in the gutter
Plug 'tpope/vim-fugitive' " git integration including blame
Plug 'vim-pandoc/vim-pandoc' " markdown etc support
Plug 'vim-pandoc/vim-pandoc-syntax' " markdown etc syntax support
Plug 'cespare/vim-toml' " toml highlighting
Plug 'ahf/cocci-syntax' " Coccinelle highlighting
Plug '/opt/jcolledge/packages/fzf' " fuzzy search
Plug 'junegunn/fzf.vim' " vim integration for fuzzy search
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} " code completion, semantic search etc.
Plug 'w0rp/ale' " linter
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " golang linter
call plug#end()

" my config
set termguicolors
colorscheme molokai

set number relativenumber
set title
set whichwrap=b,s,h,l,<,>,[,]
set mouse=a
set ignorecase
set inccommand=split
set scrolloff=5                " 5 lines before and after the current line when scrolling
set breakindent
set nojoinspaces
nnoremap <Esc><Esc> :nohlsearch<CR>
nnoremap <M-Left> <C-w>h
nnoremap <M-Down> <C-w>j
nnoremap <M-Up> <C-w>k
nnoremap <M-Right> <C-w>l
nnoremap <space>w  :wa<cr>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

highlight TabAlignment ctermbg=darkblue guibg=#11171b
match TabAlignment /[^\t]\zs\t\+/

set list
set listchars=tab:>-

highlight CocHighlightText  guibg=#333333 ctermbg=223
highlight MatchParen      guibg=#000000 guifg=#FD971F ctermbg=black ctermfg=172 gui=bold

" Identify .h files as 'c' rather than 'cpp' for ALE/ccls
augroup project
  autocmd!
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

" vim-mark
let g:mwDefaultHighlightingPalette = 'maximum'

" CamelCaseMotion
call camelcasemotion#CreateMotionMappings('<leader>')

" Pandoc customization
highlight! link Conceal Special
let g:pandoc#compiler#arguments = "-f markdown-tex_math_dollars"
let g:pandoc#formatting#extra_equalprg = "-f markdown-tex_math_dollars"

" fzf customization
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>

" coc.nvim config
" if hidden is not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=200

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[d` and `]d` for navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ],
      \             [ 'tagbar' ] ]
      \ },
      \ 'component': {
      \   'tagbar': '%{tagbar#currenttag("%s", "", "f")}'
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }



" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" ALE config
let g:ale_c_ccls_init_options = {
      \ 'cache': {
      \   'directory': '/opt/jcolledge/cache/ccls',
      \ },
      \ 'diagnostics': {
      \   'onChange': 1000,
      \   'onOpen': 0,
      \   'onSave': 0,
      \ },
      \ }


" vim-go config
let g:go_fmt_command = "goimports"
let g:go_fmt_options = {
      \ 'goimports': '-local github.com/LINBIT,github.com/piraeusdatastore,github.com/rck',
      \ }


" Bufdo command
" " Like bufdo but restore the current buffer.
function! BufDo(command)
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
endfunction
com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)
