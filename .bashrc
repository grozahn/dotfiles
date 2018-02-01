export BASH_THEME="minimal"

case "$BASH_THEME" in 
  minimal) export PS1='\[\e[1;34m\] \W \[\e[0m\]' ;;
  gentoo) export PS1='\[\e[1;32m\]\u@\h\[\e[0m\] \[\e[1;34m\]\W \$\[\e[0m\] ' ;;
esac

export EDITOR='nvim'

alias arch-wiki='w3m https://wiki.archlinux.org'
alias yd='yandex-disk --proxy=https,163.172.27.213,3128'
alias update='pacaur -Syu'
alias bashrc='$EDITOR $HOME/.bashrc'
alias q='exit'

transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

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
  SERVER="163.172.27.213:3128"
  
  export http_proxy="$SERVER"
  export https_proxy="$SERVER"
	
  vk
}
