###
# Exports
###

set -x EDITOR 'kak'

if status --is-login
    set -x PATH $PATH "$HOME/bin" "$HOME/.cargo/bin"
end

###
# Aliases
###
alias ipy='ipython'
alias ipy2='ipython2'

alias py='python3'
alias py2='python2.7'
