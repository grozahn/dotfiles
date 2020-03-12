# Set prompt theme
export BASH_THEME='gentoo'

# Import base config
source $HOME/.baserc.bash

# Set Termux root directory
export TERMUX_ROOT='/data/data/com.termux/files'
export BIN=$TERMUX_PREFIX/usr/bin
export R=$TERMUX_PREFIX

# Set default environment variables
export EDITOR='kak'

export MD="$HOME/storage/shared/Documents/markor"

# Aliases
alias sqlmap='python2.7 $HOME/pentest/sqlmap/sqlmap.py'
alias upd='apt update && apt upgrade'

# Start sshd
[ -f $HOME/.ssh/authorized_keys ] && sshd

# Import Fuzzy Finder scripts
[ -d $TERMUX_ROOT/usr/share/fzf ] && source $TERMUX_ROOT/usr/share/fzf/completion.bash
[ -d $TERMUX_ROOT/usr/share/fzf ] && source $TERMUX_ROOT/usr/share/fzf/key-bindings.bash
