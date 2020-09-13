###
# Exports
###
set -x EDITOR 'nvim'
# set -x GOPATH "$HOME/.go"

###
# Aliases
###
alias adb-screencast='adb exec-out screenrecord --output-format=h264 - | mpv -'
alias vncd='vncserver -geometry 1366x768'
alias kvncd='vncserver -kill'
alias mkqr='qrencode -t ANSI256'
alias mvim='nvim -u ~/.config/nvim/min.vim'
