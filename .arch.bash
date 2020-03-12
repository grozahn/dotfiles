# Set prompt theme
export BASH_THEME='theunraveler'

# Import base config
source $HOME/.baserc.bash

# Set default environment variables
export EDITOR='nvim'
export NNN_CONTEXT_COLORS='3214'

# Aliases
alias adb='/opt/android-sdk/platform-tools/adb'
alias adb-screencast='adb exec-out screenrecord --output-format=h264 - | mpv -'
alias awiki='w3m https://wiki.archlinux.org'
alias upd='yay -Syu'
alias vncd='vncserver -geometry 1366x768 -localhost'
alias kvncd='vncserver -kill'

# Run Neovim with minimal config
mvim() { $EDITOR -u $HOME/.config/nvim/min.vim $@; }

# Import Fuzzy Finder scripts
[ -d /usr/share/fzf ] && source /usr/share/fzf/completion.bash
[ -d /usr/share/fzf ] && source /usr/share/fzf/key-bindings.bash
