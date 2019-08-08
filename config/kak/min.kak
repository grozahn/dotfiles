# Indentation
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

# Default colorscheme
colorscheme tomorrow-night

# Highlighters
hook global KakBegin .* %{
    add-highlighter global/numbers    number-lines -relative -hlcursor -separator ' '
    add-highlighter global/matching   show-matching
    add-highlighter global/whitespace show-whitespaces -tab "▏" -lf " " -nbsp "⋅" -spc " "
    add-highlighter global/wrap       wrap -word -indent -marker ↪
}

# Mappings
map global normal '#' :comment-line<ret>
map global normal '@' :comment-block<ret>
map global normal '<c-s>' :b\ <tab>
map global normal '<c-d>' :buffer-next<ret>
map global normal '<c-a>' :buffer-previous<ret>
map global normal '<c-q>' :delete-buffer!<ret>

# Completion by Tab key
hook global InsertCompletionShow .* %{map   window insert <tab> <c-n>; map   window insert <s-tab> <c-p>}
hook global InsertCompletionHide .* %{unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p>}

# Clang completion
hook global WinSetOption filetype=(c|cpp) %{
    ctags-enable-autocomplete;
    clang-enable-autocomplete
}

# Python completion and linting
hook global WinSetOption filetype=(python) %{
    set-option global lintcmd flake8;
    lint-enable;
    jedi-enable-autocomplete
}

# Run linter after Python file write
hook global BufWritePre .*\.py$ %{lint}

# Disable expandtab hack for Makefile
hook global WinSetOption filetype=(makefile) %{remove-hooks global expandtab}
