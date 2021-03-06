###
# Exports
###
set -x EDITOR 'nvim'
set -x GOPATH "$HOME/.go"

if status --is-login
    set -x PATH $PATH "$HOME/.cargo/bin:$HOME/.local/bin"
end

###
# Aliases
###
alias adb='/opt/android-sdk/platform-tools/adb'
alias adb-screencast='adb exec-out screenrecord --output-format=h264 - | mpv -'
alias awiki='w3m https://wiki.archlinux.org'
alias upd='yay -Syu'
alias vncd='vncserver -geometry 1366x768'
alias kvncd='vncserver -kill'
alias mkqr='qrencode -t ANSI256'
alias mvim='nvim -u ~/.config/nvim/min.vim'
