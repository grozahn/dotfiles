# Indentation
set-option global softtabstop 4
set-option global tabstop 4
set-option global indentwidth 4

# expandtab hack
map global insert <backspace> '<a-;>:insert-bs<ret>'
hook global -group expandtab InsertChar \t %{
    exec -draft h@
}

def -hidden insert-bs %{
    try %{
        # delete indentwidth spaces before cursor
        exec -draft h %opt{indentwidth}HL <a-k>\A<space>+\z<ret> d
    } catch %{
        exec <backspace>
    }
}

# Colorscheme
# tomorrow-night, dracula, solarized-light
colorscheme tomorrow-night

# Highlighters
hook global KakBegin .* %{
    add-highlighter global/numbers    number-lines -relative -hlcursor -separator ' '
    add-highlighter global/matching   show-matching
    add-highlighter global/whitespace show-whitespaces -tab "▏" -lf " " -nbsp "⋅" -spc " "
    add-highlighter global/wrap       wrap -word -indent -marker ↪
}

# convert between snake_case and camelCase
def to-camelcase %{
    exec '`s[-_<space>]<ret>d~<a-i>w'
}

def to-snakecase %{
    exec '<a-:><a-;>s-|[a-z][A-Z]<ret>;a<space><esc>s[-\s]+<ret>c_<esc><a-i>w`'
}

# Mappings
map global user s :b\ <tab> -docstring "Select buffer"
map global user d :buffer-next<ret> -docstring "Next buffer"
map global user a :buffer-previous<ret> -docstring "Previous buffer"
map global user q :delete-buffer!<ret> -docstring "Delete buffer"

map global user m :man<ret> -docstring "Open Man page"

map global user y '<a-|>xsel -ib<ret>' -docstring "Yank selection to system clipboard"
map global user c '<a-|>wl-copy<ret>' -docstring "Yank selection to system clipboard (Wayland)"

map global normal '#' :comment-line<ret>
map global normal '@' :comment-block<ret>

# Completion by Tab key
hook global InsertCompletionShow .* %{map   window insert <tab> <c-n>; map   window insert <s-tab> <c-p>}
hook global InsertCompletionHide .* %{unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p>}

# Clang completion
hook global WinSetOption filetype=(c|cpp) %{
    map global goto d "<esc>:ctags-search<ret>" -docstring 'Jump to tag'

    ctags-enable-autocomplete;
    clang-enable-autocomplete
}

# Python completion and linting
hook global WinSetOption filetype=(python) %{
    set window lintcmd flake8;
    lint-enable;
    jedi-enable-autocomplete
}

# Run linter after Python file write
hook global BufWritePre .*\.py$ %{lint}

# Disable expandtab hack for Makefile
hook global WinSetOption filetype=(makefile) %{remove-hooks global expandtab}
