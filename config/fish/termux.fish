###
# Exports
###
set -x TERMUX_PREFIX '/data/data/com.termux/files'
set -x BIN "$TERMUX_PREFIX/usr/bin"
set -x R $TERMUX_PREFIX

set -x EDITOR 'kak'

set -g MD "$HOME/storage/shared/Documents/markor"

###
# Aliases
###
alias sqlmap='python2.7 $HOME/pentest/sqlmap/sqlmap.py'
alias upd='apt update && apt upgrade'

###
# After init
###

# Start sshd
if test -f ~/.ssh/authorized_keys; sshd; end
