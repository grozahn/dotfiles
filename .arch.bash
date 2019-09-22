# Set prompt theme
export BASH_THEME='theunraveler'

# Import base config
source $HOME/.baserc.bash

# Set default environment variables
export EDITOR='nvim'

# Aliases
alias adb-screencast='adb exec-out screenrecord --output-format=h264 - | mpv -'
alias awiki='w3m https://wiki.archlinux.org'
alias upd='yay -Syu'

# Run Neovim with minimal config
mvim() { $EDITOR -u $HOME/.config/nvim/min.vim $@; }

# Import Fuzzy Finder key bindings
[ -d /usr/share/fzf ] && source /usr/share/fzf/key-bindings.bash
