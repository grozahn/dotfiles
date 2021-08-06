# Source global definitions
[ -f /etc/bashrc ] && . /etc/bashrc

# Set prompt theme
#   Available themes:
#    - theunraveler
#    - gentoo
#    - agnoster
#    - minimal
export BASH_THEME='agnoster'

# Import base config
. $HOME/.baserc.bash

# Set default environment variables
export EDITOR='kak'

# Aliases
alias op='xdg-open'
alias adb-rec='adb exec-out screenrecord --output-format=h264 - | mpv -'
alias vncd='vncserver -geometry'
alias kvncd='vncserver -kill'
alias flp='flatpak'
alias rsup='rustup'
alias enw='emacs -nw'
alias pm='podman'
alias pmc='podman-compose'
alias doom='~/.emacs.d/bin/doom'

# Enable fzf key bindings
[ -d /usr/share/fzf ] && . /usr/share/fzf/shell/key-bindings.bash

# Enable fzf tab completion
. ~/.bin/fzf-bash-completion.sh
bind -x '"\t": fzf_bash_completion'

# [[ -s "$HOME/.xmake/profile" ]] && source "$HOME/.xmake/profile" # load xmake profile

alias luamake=/home/zaurix/.config/nvim/lua-language-server/3rd/luamake/luamake
