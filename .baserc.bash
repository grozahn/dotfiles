# Define prompt themes
case "$BASH_THEME" in
    theunraveler)
        export PS1='\[\e[35m\][\W] \[\e[0m\]' ;;
    gentoo)
        export PS1='\[\e[1;32m\]\u@\h \[\e[1;34m\]\W \$ \[\e[0m\]' ;;
    agnoster)
        export PS1='\[\e[7;34m\] \W \[\e[0;34m\] \[\e[0m\]' ;;
    minimal)
        export PS1='\[\e[1;34m\] \W \[\e[0m\]' ;;
esac

###
# Exports
###
export TERM='xterm-256color'
export PAGER='less'
export EDITOR='vi'

# Set bash history size
export HISTSIZE=50000
export HISTFILESIZE=

###
# Aliases
###

# Dumb things
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls --color=tty'
alias nv='nvim'
alias shrc='$EDITOR $HOME/.bashrc'
alias fetch='neofetch --ascii_distro netbsd'

# Wrappers using fzf
alias kns='kak -s $(basename $PWD)'  # kakoune new session

# Python stuff
alias pyftpd='python -m pyftpdlib -w'
alias pyhttpd='python -m http.server 8080'
alias py='python3'
alias py2='python2'
alias ipy='ipython'

###
# User defined functions
###

# Play mjpeg stream from ScreenStream server running on smartphone
scrplay() { # (host: $1, port=8080: $2)
    [ -z "$1" ] && {
        echo "Usage: scrplay <host> [port]"
        return 1
    }

    [ -n "$2" ] && port="$2" || port=8080

    mpv "http://${1}:${port}/stream.mjpeg"
}

# (fzf) Open file in $EDITOR
edf() {
    $EDITOR $(find $1 -type f | fzf +s)
}

# Clone git repo
clone() {
    url=$2
    if [ $1 ] && [ -n $2 ]; then
        case $1 in
        'gl')
            url="https://gitlab.com/$url" ;;
        'gh')
            url="https://github.com/$url.git" ;;
        *)
            echo 'Wrong host keyword: use gh (github) or gl (gitlab)'
            return 1
        esac
        git clone $url
    fi
}

# Attach to Kakoune session
kat() {
    [[ -n $(kak -l) ]] && kak -c $(kak -l | fzf) $@ || kak $@
}

# Convert ASCII string to HEX in reverse order
atox() { echo -n "$1" | rev | od -A n -t x1 | sed 's/ /\\\x/g'; }

# Search for specific string in files
ingrep() { grep -rnI $2 -e $1 | fzf; }

# Create new named tmux session
tns() { # (session: $1)
    [ -n "${1}" ] && session="${1}" || session="$(basename ${PWD})"
    tmux new-session -s "${session}"
}

# Attach to tmux session
tat() {
    [ $(tmux ls | wc -l) -gt 1 ] && {
        tmux attach -t $(tmux ls | fzf | sed 's/:.*$//g')
    } || {
        tmux attach || tns "${@}"
    }
}

# Set proxy variables
use_proxy() {
    export http_proxy=$1
    export https_proxy=$http_proxy
    export ftp_proxy=$http_proxy
    export rsync_proxy=$http_proxy
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
}

# Pack archive
pk() {
    if [ $1 ]; then
        case $1 in
            tbz) tar cjvf $2.tar.bz2 $2     ;;
            tgz) tar czvf $2.tar.gz  $2     ;;
            tar) tar cpvf $2.tar  $2        ;;
            bz2) bzip $2                    ;;
            gz)  gzip -c -9 -n $2 > $2.gz   ;;
            zip) zip -r $2.zip $2           ;;
            7z)  7z a $2.7z $2              ;;
            *)   echo "'$1' is wrong file type" ;;
        esac
    fi
}

# Extract archive
ex() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2) tar xvjf $1   ;;
            *.tar.gz)  tar xvzf $1   ;;
            *.tar.xz)  tar xvfJ $1   ;;
            *.bz2)     bunzip2 $1    ;;
            *.rar)     unrar x $1    ;;
            *.gz)      gunzip $1     ;;
            *.tar)     tar xvf $1    ;;
            *.tbz2)    tar xvjf $1   ;;
            *.tgz)     tar xvzf $1   ;;
            *.zip)     unzip $1      ;;
            *.Z)       uncompress $1 ;;
            *.7z)      7z x $1       ;;
            *)         echo "'$1' can not be extracted with ex()" ;;
        esac
    else
        echo "'$1' is not valid file"
    fi
}
