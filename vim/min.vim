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

" Autocompletion
function! SuperTab()
    let l:part = strpart(getline('.'),col('.')-2,1)
    if (l:part=~'^\W\?$')
        return "\<Tab>"
    else
        return "\<C-n>"
    endif
endfunction

inoremap <Tab> <C-R>=SuperTab()<CR>

" Statusline
function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%{StatuslineGit()}
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ 
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c

" Common settings
set noswapfile
set listchars=tab:\▏\ 
set list

filetype plugin indent on
autocmd FileType make setlocal noexpandtab

" Encoding
set encoding=utf-8
set termencoding=utf-8

" Tabs
nnoremap <C-a> :tabprevious<CR>
nnoremap <C-d> :tabnext<CR>
nnoremap <C-s> :tabnew<CR>
nnoremap <C-q> :tabclose<CR>

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
set termguicolors
colorscheme base16-tomorrow-night 
