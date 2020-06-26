" vim:fileencoding=utf-8:foldmethod=marker

" User-defined functions {{{
"
" Terminal toggle
if has("nvim")
    nnoremap <silent> <F4> :botright new term://$SHELL<CR>
    tnoremap <silent> <F4> <C-\><C-n> :bd!<CR>
    tnoremap <silent> <S-F4> <C-\><C-n>
    autocmd TermOpen * startinsert! | setlocal nonumber norelativenumber | resize 14
endif

" Netrw toggle
let g:netrw_win = 0
let g:netrw_hide = 1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+,\(^\|\s\s\)ntuser\.\S\+'

function! NetrwToggle()
    if win_gotoid(g:netrw_win)
        :q
        let g:netrw_win = 0
    else
        :Lexplore 20
        let g:netrw_win = win_getid()
    endif
endfunction

nnoremap <F3> :call NetrwToggle()<CR>

" Keyword completion
function! SuperTab()
    let l:part = strpart(getline('.'),col('.')-2,1)
    if (l:part=~'^\W\?$')
        return "\<Tab>"
    else
        return "\<C-n>"
    endif
endfunction

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
set path+=**

set noswapfile
set nobackup

set listchars=tab:▏\ ,eol:\ ,extends:,precedes:,space:\ ,trail:⋅
set list

filetype plugin indent on
set smartindent

set completeopt=longest,menuone

" Filetype specific
autocmd FileType make setlocal noexpandtab
autocmd FileType c,cpp setlocal noexpandtab
autocmd FileType go setlocal noexpandtab
autocmd FileType python setlocal colorcolumn=80

" Encoding
set encoding=utf-8
set termencoding=utf-8

" User mappings
nnoremap ,a :tabprevious<CR>
nnoremap ,d :tabnext<CR>
nnoremap ,s :tabnew<CR>
nnoremap ,q :tabclose<CR>
vnoremap ,m :Man<CR>
vnoremap ,y "+y

inoremap <Tab> <C-R>=SuperTab()<CR>

" Tab key
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Navigation
set cursorline
set mouse=a
set relativenumber
set nu

" Style
syntax enable
set termguicolors
colorscheme base16-tomorrow-night
" colorscheme base16-gruvbox-dark-hard

" Statusline
set statusline=
set statusline+=%#Title#
set statusline+=%#LineNr#
set statusline+=%#Visual#
set statusline+=\ %f\ 
set statusline+=%#LineNr#
set statusline+=%m
set statusline+=%=
set statusline+=\%{&filetype}
set statusline+=\ \|
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ (%{&fileformat})
set statusline+=\ \ %p%%\ 
set statusline+=\ %l:%c
set statusline+=\ 
"}}}
