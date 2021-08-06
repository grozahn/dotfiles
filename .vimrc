" # General vars
" Encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" For file searching
set path+=**

" Useless 
set noswapfile
set nobackup

" Enable indentation and syntax highlighting
filetype plugin indent on
syntax enable
set smartindent

" Tab width
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Navigation
set cursorline
set mouse=a
set relativenumber
set nu

" Colorscheme
set termguicolors
colorscheme base16-tomorrow-night

" # Mappings

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_list_hide = '^\.'

" Bit quicker command typing
nnoremap ; :

" Quick shortcut for disabling search results highlighting
nnoremap <Esc><Esc> :noh<CR>

" Repeat last macro
nnoremap <Space> @@

" Tab and buffer ops
nnoremap ,a :tabprevious<CR>
nnoremap ,d :tabnext<CR>
nnoremap ,t :tabnew<CR>
nnoremap ,w :tabclose<CR>
nnoremap ,s :b<Space>
nnoremap ,q :bdelete!<CR>

" Window movement
nnoremap <C-h> <C-w>h 
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" File browsing and searching
nnoremap ,e :Lexplore 30<CR>
nnoremap <C-p> :find<Space>

" Terminal
nnoremap <C-\> :tab terminal<CR>
tnoremap <C-\> <C-\><C-n>

" Misc
nnoremap ,# :hi! link Comment

" # Filetype specific
autocmd Filetype c,c++,make,go set noexpandtab
autocmd FileType python set colorcolumn=80
autocmd Filetype lua,lisp set tabstop=2 softtabstop=2 shiftwidth=2
