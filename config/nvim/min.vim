" vim:fileencoding=utf-8:foldmethod=marker

" User-defined functions {{{
"
" Terminal toggle
if has("nvim")
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

    nnoremap <F4> :call TerminalToggle(12)<CR>
    tnoremap <F4> <C-\><C-n>:call TerminalToggle(12)<CR>
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

" Auto (Omni) completion
function! SmartTabComplete()
    if (strpart(getline('.'), col('.') - 2, 1) !~ '\v(\w|\.|\/|\:)')
        return "\<tab>"
    endif
    let l:line = matchstr(strpart(getline('.'), - 1, col('.') + 1), "[^ \t]*$")
    if match(l:line, '\.') != -1
        return "\<C-X>\<C-O>"
    elseif match(l:line, '\/') != -1
        return "\<C-X>\<C-F>"
    else
        return "\<C-X>\<C-P>"
    endif
endfunction

" Keyword completion
function! SuperTab()
    let l:part = strpart(getline('.'),col('.')-2,1)
    if (l:part=~'^\W\?$')
        return "\<Tab>"
    else
        return "\<C-n>"
    endif
endfunction

" Statusline
function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
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
set noswapfile
set nobackup

set listchars=tab:▏\ ,eol:\ ,extends:,precedes:,space:\ ,trail:⋅
set list

filetype plugin indent on
set smartindent

set completeopt=longest,menuone
set omnifunc=syntaxcomplete#Complete

" Filetype specific
autocmd FileType make setlocal noexpandtab
autocmd FileType python setlocal colorcolumn=80

" Encoding
set encoding=utf-8
set termencoding=utf-8

" Tabline mappings
nnoremap <C-a> :tabprevious<CR>
nnoremap <C-d> :tabnext<CR>
nnoremap <C-s> :tabnew<CR>
nnoremap <C-q> :tabclose<CR>

" Complete function mappings
let smart_complete = 1

if smart_complete
    inoremap <silent><expr><Tab> pumvisible() ? "\<C-n>" : "\<C-r>=SmartTabComplete()<CR>"
    inoremap <silent><expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
else
    inoremap <Tab> <C-R>=SuperTab()<CR>
endif

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

" Statusline
set statusline=
set statusline+=%#Title#
set statusline+=%{StatuslineGit()}
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