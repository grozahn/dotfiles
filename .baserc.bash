export TERM='xterm-256color'

# Set history size
export HISTSIZE=50000
export HISTFILESIZE=

# Define prompt themes
case "$BASH_THEME" in
    theunraveler)
        export PS1='\[\e[35m\][\W] \[\e[0m\]' ;;
    gentoo)
        export PS1='\[\e[1;32m\]\u@\h\[\e[0m\] \[\e[1;34m\]\W \$ \[\e[0m\]' ;;
    arrow)
        export PS1='\[\e[1;32m\]-> \[\e[0m\]' ;;
    minimal)
        export PS1='\[\e[1;34m\] \W \[\e[0m\]' ;;
esac

# Set default environment variables
export PAGER='less'
export EDITOR='vi'
export NNN_CONTEXT_COLORS='3214'

alias fetch='neofetch --ascii_distro netbsd'
alias shrc='$EDITOR $HOME/.bashrc'
alias ls='ls --color=tty'
alias nv='nvim'

# Kakoune attach
kat() { if [[ $(kak -l) != '' ]]; then kak -c $(kak -l | fzf) $@; else kak $@; fi }

# Run Neovim with minimal config
mvim() { $EDITOR -u $HOME/.config/nvim/min.vim $@; }

# Convert ASCII string to HEX in reverse (Little-Endian) order
a2hex() { echo -n "$1" | rev | od -A n -t x1 | sed 's/ /\\\x/g'; }

# Search for specific string in files
insearch() { grep -rnI $2 -e $1 | fzf; }

# Tmux session chooser
tms() {
    if [[ $(tmux ls | wc -l) -gt 1 ]]; then
        tmux attach -t $(tmux ls | fzf | sed 's/:.*$//g')
    else
        tmux attach || tmux new
    fi
}

use_proxy() {
    export http_proxy=$1
    export https_proxy=$http_proxy
    export ftp_proxy=$http_proxy
    export rsync_proxy=$http_proxy
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
}

transfer() {
    if [ $# -eq 0 ]; then
        echo -e "Usage: transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
        return 1
    fi

    tmpfile=$( mktemp -t transferXXX )
    if tty -s; then
        basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g')
        curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile
    else
        curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile
    fi

    cat $tmpfile; echo; rm -f $tmpfile
}

# Pack archive
pk () {
    if [ $1 ] ; then
        case $1 in
            tbz) tar cjvf $2.tar.bz2 $2     ;;
            tgz) tar czvf $2.tar.gz  $2     ;;
            tar) tar cpvf $2.tar  $2        ;;
            bz2) bzip $2                    ;;
            gz)  gzip -c -9 -n $2 > $2.gz   ;;
            zip) zip -r $2.zip $2           ;;
            7z)  7z a $2.7z $2              ;;
            *)   echo "'$1' can not be extracted with pk()" ;;
        esac
    else
        echo "'$1' is not valid file"
    fi
}

# Extract archive
ex () {
    if [ -f $1 ] ; then
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
