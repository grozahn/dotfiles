" vim:fileencoding=utf-8:foldmethod=marker

" Plugins {{{
"
call plug#begin('~/.local/share/nvim/plugged')

" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Tools
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'grozahn/nerdtree-file-icon-plugin', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'

" Edit
Plug 'matze/vim-move'
Plug 'raimondi/delimitmate'

" Highlight
Plug 'kelwin/vim-smali'
Plug 'octol/vim-cpp-enhanced-highlight'

" Language Client
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" NCM2
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" NCM2 Completion sources
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

call plug#end()
"}}}

" User-defined functions {{{
"
" Terminal toggle
if has("nvim")
    nnoremap <silent> <F4> :botright new term://$SHELL<CR>
    tnoremap <silent> <F4> <C-\><C-n> :bd!<CR>
    tnoremap <silent> <S-F4> <C-\><C-n>
    autocmd TermOpen * startinsert! | setlocal nonumber norelativenumber | resize 14
endif

" Strip trailing whitespaces
function! StripTrailingWhitespace()
    " Save cursor position
    let l:save = winsaveview()
    " Remove trailing whitespace
    %s/\s\+$//e
    " Move cursor to original position
    call winrestview(l:save)
    echo "Stripped trailing whitespace"
endfunction
"}}}

" Common settings {{{
"
set noswapfile
set nobackup
set signcolumn=yes
" set foldmethod=marker

set listchars=tab:▏\ ,eol:\ ,extends:,precedes:,space:\ ,trail:⋅
set list

filetype plugin indent on
set smartindent

" Filetype specific
autocmd FileType make setlocal noexpandtab
autocmd FileType go setlocal noexpandtab
autocmd FileType python setlocal colorcolumn=80

" Encoding
set encoding=utf-8
set termencoding=utf-8

" Tab key
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set wildcharm=<Tab>

" Navigation
set cursorline
set mouse=a
set relativenumber
set nu

" Style
syntax enable
set termguicolors
colorscheme base16-tomorrow-night
"}}}

" Plugins config {{{
"
" Airline
set noshowmode
let g:airline_section_y = '%{&encoding} (%{&fileformat})'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0

" NCM2 Config
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Language Client
set hidden
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_formatting()

let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'go':     ['gopls'],
    \ 'cpp':    ['clangd'],
    \ 'c':      ['clangd'],
\ }

nmap <F5> :call LanguageClient_contextMenu()<CR>
nmap <silent> F :call LanguageClient#textDocument_rename()<CR>
nmap <silent> J :call LanguageClient#textDocument_signatureHelp()<CR>
nmap <silent> <C-k> :call LanguageClient#textDocument_hover()<CR>
nmap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nmap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>

" NERDTree
let NERDTreeMinimalUI = 1
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1

let g:NERDTreeDirArrowExpandable = '🗂'
let g:NERDTreeDirArrowCollapsible = '▾'

" Fuzzy Finder
let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment']
\ }

let g:fzf_tags_command = 'ctags -R'

" Mapping
nnoremap <F1>  :AirlineToggle<CR>
nnoremap <F2>  :TagbarToggle<CR>
nnoremap <F3>  :NERDTreeToggle<CR>

nnoremap <C-s> :buffer <Tab>
nnoremap <C-a> :bprevious<CR>
nnoremap <C-d> :bnext<CR>
nnoremap <C-q> :bdelete!<CR>

" Tagbar
let g:tagbar_compact = 1
let g:tagbar_autoclose = 1
"}}}
