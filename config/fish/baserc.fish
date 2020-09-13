###
# Exports
###
set -x PAGER 'less'
set -x EDITOR 'vi'

###
# Aliases
###
alias fetch='neofetch --ascii_distro netbsd'
alias ls='ls --color=tty'
alias pyftpd='python3 -m pyftpdlib -w'
alias pyhttpd='python3 -m http.server 8080'
alias kns='kak -s (basename $PWD)'  # kakoune new session
alias tns='tmux new-session -s (basename $PWD)'  # tmux new session
alias nv='nvim'

###
# User defined functions
###
function fh --description "List command history with fzf"
    set -l cmd (history | fzf +s);
    commandline -- "$cmd"
end

function cdf --description "Do cd using fzf"
    cd (find -type d -not -path '*/\.*' | fzf +s)
end

function kat --description "Attach to Kakoune session"
    set a (kak -l)
    if test "$a" != ''
        kak -c (kak -l | fzf) $argv
    else
        kak -s (basename $PWD) $argv
    end
end

function tat --description "Attach to tmux session"
    if test (tmux ls | wc -l) -ge 1
        tmux attach -t (tmux ls | fzf | sed 's/:.*$//g')
    else
        tmux attach || tmux new
    end
end

function atox --description "Convert ASCII string to HEX"
    if test -z $argv[1]
        return 1
    end
    echo -n "$argv[1]" | rev | od -A n -t x1 | sed 's/ /\\\x/g';
end

function ingrep --description "Recursive grep"
    grep -rnI $argv[2] -e $argv[1] | fzf
end

function use_proxy --description "Set proxy variables"
    if test -z $argv[1]
        return 1
    end

    set -x http_proxy $argv[1]
    set -x https_proxy $http_proxy
    set -x ftp_proxy $http_proxy
    set -x rsync_proxy $http_proxy
    set -x no_proxy "localhost,127.0.0.1,localaddress,.localdomain.com"
end

function pk --description "Pack files to archive"
    if test -n $argv[1]
        switch $argv[1]
            case "tbz"; tar cjvf "$argv[2].tar.bz2" $argv[2]
            case "tgz"; tar czvf "$argv[2].tar.gz" $argv[2]
            case "tar"; tar cpvf "$argv[2].tar" $argv[2]
            case "bz2"; bzip $argv[2]
            case "gz";  gzip -c -9 -n $argv[2] > "$argv[2].gz"
            case "zip"; zip -r "$argv[2].zip" $argv[2]
            case "7z";  7z a "$argv[2].7z" $argv[2]
            case "*"
                echo "'$argv[1]' is wrong file type"
        end
    end
end

function ex --description "Extract archive"
    if test -n $argv[1]
        switch $argv[1]
            case "*.tar.bz2"; tar xvjf $argv[1]
            case "*.tar.gz"; tar xvzf $argv[1]
            case "*.tar.xz"; tar xvfJ $argv[1]
            case "*.bz2"; bunzip2 $argv[1]
            case "*.rar"; unrar x $argv[1]
            case "*.gz"; gunzip $argv[1]
            case "*.tar"; tar xvf $argv[1]
            case "*.tbz2"; tar xvjf $argv[1]
            case "*.tgz"; tar xvzf $argv[1]
            case "*.zip"; unzip $argv[1]
            case "*.Z"; uncompress $argv[1]
            case "*.7z"; 7z x $argv[1]
            case "*"
                echo "'$argv[1]' can not be extracted with ex()" ;;
        end
    end
end
