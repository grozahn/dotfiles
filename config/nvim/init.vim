" vim:fileencoding=utf-8:fdm=marker

" # Plugins {{{
"
call plug#begin('~/.local/share/nvim/plugged')

" ## UI

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'grozahn/colorschemes.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" ## Tools
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" ## Editing
Plug 'matze/vim-move'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'raimondi/delimitmate'
Plug 'scrooloose/nerdcommenter'

" ## Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" ## Neovim LSP client
" - Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" - Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'

" ## Lang specific
" - Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" - Golang
Plug 'fatih/vim-go'

" - C/C++
Plug 'octol/vim-cpp-enhanced-highlight'

" - Markdown
Plug 'plasticboy/vim-markdown'

" - TOML
Plug 'cespare/vim-toml'

" - YAML
" replace the built-in YAML support
Plug 'stephpy/vim-yaml'
Plug 'pedrohdz/vim-yaml-folds'

" - Smali
Plug 'kelwin/vim-smali'

" - vim-polyglot for language support for over 100 langauges
Plug 'sheerun/vim-polyglot'

call plug#end()
"}}}

" # User-defined functions {{{
"
" ## Terminal toggle
if has("nvim")
    let g:term_win = 0
    let g:term_buf = 0

    function! TerminalToggle(height)
        if win_gotoid(g:term_win)
            hide
            let g:term_win = 0
        else
            if !buffer_exists(g:term_buf)
                let g:term_buf = 0
            endif
            if !g:term_buf
                exec "botright new term://$SHELL"
                let g:term_buf = bufnr("")
            else
                exec "botright sbuffer" .  g:term_buf
            endif
            startinsert!
            exec "resize" . a:height

            let g:term_win = win_getid()
        endif
    endfunction

    nnoremap <silent> <F4> :call TerminalToggle(14)<CR>
    tnoremap <silent> <F4> <C-\><C-n> :call TerminalToggle(14)<CR>
    tnoremap <silent> <S-F4> <C-\><C-n>
    autocmd TermOpen * | setlocal nonumber norelativenumber signcolumn=no
endif

" ## Strip trailing whitespaces
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

" # Common settings {{{
"
" ## Generals

" Useless
set noswapfile
set nobackup

" Folding
set foldmethod=manual

" Lower delay before diagnostics messages will be shown
set updatetime=500

" Time for keys combo waiting
set timeoutlen=400

" Should accelerate UI
set ttyfast
set lazyredraw

" Show tabs and trailing whitespaces
set listchars=tab:▏\ ,eol:\ ,extends:,precedes:,space:\ ,trail:⋅
set list

" Encoding
set encoding=utf-8
set termencoding=utf-8

" Enable smart indent method
set smartindent

" Tab key
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Use system clipboard
set clipboard=unnamedplus

" /g by default
set gdefault

" Enable incremental search
set incsearch

" Netrw
let g:netrw_banner = 0
let g:netrw_list_hide = '^\.'

" ## Automatically open the quickfix window after silent command execution
autocmd QuickFixCmdPost * :copen

" ## Filetype specific
autocmd Filetype c,c++,make,go set noexpandtab
autocmd FileType python set colorcolumn=80
autocmd BufWritePost Cargo.toml :lua vim.lsp.restart_client("rls")

" ## Navigation
set cursorline
set mouse=a
set relativenumber
set nu

" ## UI
set signcolumn=yes
set colorcolumn=100
set termguicolors
set background=light
colorscheme base16-tomorrow-night

" ## User mappings
" Use comma (like in Kakoune) as leader key
let mapleader = ","

" Bit quicker command typing
nnoremap ; :

" Quick shortcut for disabling search results highlighting
nnoremap <Esc><Esc> :noh<CR>

" Leave cursor after the new text
noremap p gp
noremap P gP
noremap gp p
noremap gP P

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Repeat last macro
nnoremap <Space> @@

" Buffer ops
nnoremap <leader>s :Buf<CR>
nnoremap <leader>a :bprevious<CR>
nnoremap <leader>d :bnext<CR>
nnoremap <leader>q :bdelete!<CR>

" Window movement
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" Yank to system clipboard
vnoremap <leader>y "+y
nnoremap <leader>y "+y

" Misc
nnoremap <leader># :hi! link Comment

" Build/Run programs
autocmd FileType c,c++,go nnoremap <silent> <leader>b :silent make<CR>

"}}}

" # Plugins config {{{
"
" ## Airline
set noshowmode
set laststatus=2

let g:airline_section_y = '%{&encoding} (%{&fileformat})'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" ## Tagbar
let g:tagbar_compact = 1
let g:tagbar_autoclose = 1

nnoremap <leader>t :TagbarToggle<CR>

" ## fzf.vim
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
let g:fzf_layout = { 'down': '~40%' }

command! F :Files

nnoremap <C-p> :F<CR>
nnoremap q: :History:<CR>
nnoremap q/ :History/<CR>
nnoremap <leader>/ :BLines<CR>

" ## NERDTree
let NERDTreeMinimalUI = 1
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1

nnoremap <leader>e :NERDTreeToggle<CR>

" ## NERDCommenter
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" ## Neovim LSP client
lua require("lsp")

set hidden
set completeopt=menuone,noselect
set pumheight=14

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

command! -nargs=1 LspRestartClient lua vim.lsp.restart_client(<f-args>)

" ## rust.vim
let g:rustfmt_autosave = 0 " automatically rustfmt on save
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_fold = 1
"}}}
