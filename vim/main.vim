" Plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" UI
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'ryanoasis/vim-devicons'

" Completion
if has('nvim')
    Plugin 'Shougo/deoplete.nvim'
else
    Plugin 'Shougo/deoplete.nvim'
    Plugin 'roxma/nvim-yarp'
    Plugin 'roxma/vim-hug-neovim-rpc'
endif

" Tools
Plugin 'w0rp/ale'
Plugin 'matze/vim-move'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'raimondi/delimitmate'

" C/C++
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'zchee/deoplete-clang'

" Python
Plugin 'zchee/deoplete-jedi'

call vundle#end()

" TrueColor
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
    set termguicolors
endif

" Terminal toggle
if has('nvim')
    let g:term_buf = 0
    let g:term_win = 0

    function! TerminalToggle(height)
        if win_gotoid(g:term_win)
            hide
        else
            botright new
            exec "resize " . a:height
            try
                exec "buffer " . g:term_buf
            catch
                call termopen($SHELL, {"detach": 0})
                let g:term_buf = bufnr("")
            endtry
            startinsert!
            let g:term_win = win_getid()
        endif
    endfunction

    nnoremap <F4> :call TerminalToggle(10)<CR>
    tnoremap <F4> <C-\><C-n>:call TerminalToggle(10)<CR>
endif

" ----------------------------

" Common settings
set nocompatible
set noswapfile
set signcolumn=yes
filetype off
filetype plugin on
filetype plugin indent on

" Encoding
set encoding=utf-8
set termencoding=utf-8

" Deoplete
set completeopt-=preview
let g:deoplete#enable_at_startup = 1

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" Deoplete Clang
let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/lib/clang/'

" ALE
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_delay = 350
let g:ale_sign_error = '⬥ '
let g:ale_sign_warning = '⬥ '

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" NERDTree
let NERDTreeMinimalUI = 1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1

" Mapping
nnoremap <F1> :AirlineToggle<CR>
nnoremap <F2> :TagbarToggle<CR>
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <C-a> :bprevious<CR>
nnoremap <C-d> :bnext<CR>
nnoremap <C-q> :bdelete<CR>

" Tab key
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Navigation
set cursorline
set mouse=a
set number

" Style
syntax enable
set background=dark
colorscheme deep-space 

" Other
let g:tagbar_compact = 1
" let g:indentLine_char = '▏'
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

