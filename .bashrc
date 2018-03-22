export BASH_THEME="minimal"

case "$BASH_THEME" in 
  minimal) export PS1='\[\e[1;34m\] \W \[\e[0m\]' ;;
  gentoo) export PS1='\[\e[1;32m\]\u@\h\[\e[0m\] \[\e[1;34m\]\W \$\[\e[0m\] ' ;;
esac

export EDITOR='nvim'

alias adb-screencast='adb exec-out screenrecord --output-format=h264 - | mpv -'
alias arch-wiki='w3m https://wiki.archlinux.org'
alias yd='yandex-disk --proxy=https,89.236.17.108,3128'
alias update='pacaur -Syu'
alias bashrc='$EDITOR $HOME/.bashrc'
alias q='exit'

use_proxy() {
  export http_proxy=$1
  export https_proxy=$http_proxy
  export ftp_proxy=$http_proxy
  export rsync_proxy=$http_proxy
  export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
}

converter() {
  case $1 in
    ascii)
      echo -n "$2" | rev | od -A n -t x1 | sed 's/ /\\x/g' 
      ;;
    hex)
      echo -e "$2" | rev
      ;;
  esac
}

transfer() {
  if [ $# -eq 0 ]; then
    echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
    return 1
  fi 
  
  tmpfile=$( mktemp -t transferXXX )
  if tty -s; then
    basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g')
    curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile
  else
    curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile
  fi
  
  cat $tmpfile; rm -f $tmpfile;
}

mkshellcode() {
  objdump -d $1|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'
}

recorder() {
  FILENAME=$HOME/screencast-$(date +%Y-%m-%d_%H.%M.%S).mp4

  case $1 in
    --no-sound)
      ffmpeg -f x11grab -r 60 -s 1366x768 -i :0.0 -c:v libx264 -preset superfast -crf 0 $FILENAME
      ;;
    --with-sound)
      ffmpeg -f alsa -ac 1 -i pulse -f x11grab -r 60 -s 1366x768 -i :0.0 -c:v libx264 -preset superfast -crf 0 $FILENAME
      ;;
  esac
}

vk-cli() {
  export TERM=xterm
  export http_proxy="89.236.17.108:3128"
  export https_proxy="$http_proxy"
	
  vk
}

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
