export TERM=xterm-256color
export ZSH=/home/$USER/.oh-my-zsh

ZSH_THEME="gentoo"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export DEFAULT_USER=$USER
export EDITOR='nvim'

alias arch-wiki="w3m https://wiki.archlinux.org"
alias yd="yandex-disk --proxy=https,89.236.17.106,3128"
alias update='pacaur -Syu'
alias zshrc='$EDITOR $HOME/.zshrc'
alias q="exit"

transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

converter() {
  if [[ $1 == 'ascii' ]]; then
	  echo -n "$2" | rev | od -A n -t x1 | sed 's/ /\\x/g'
  elif [[ $1 == 'hex' ]]; then 
	  echo -e "$2" | rev
  fi
}

mkshellcode() {
  objdump -d $1|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'
}

recorder() {
  FILENAME=$HOME/screencast_$(date +%Y-%m-%d_%H:%M:%S).mkv

  if [[ $1 == '--no-sound' ]]; then
    ffmpeg -f x11grab -r 60 -s 1366x768 -i :0.0 -c:v libx264 -preset superfast -crf 0 $FILENAME
  elif [[ $1 == '--with-sound' ]]; then 
    ffmpeg -f alsa -ac 1 -i pulse -f x11grab -r 60 -s 1366x768 -i :0.0 -c:v libx264 -preset superfast -crf 0 $FILENAME
  fi  
}

vk-cli() {
  SERVER="89.236.17.106:3128"
  
  export http_proxy="$SERVER"
  export https_proxy="$SERVER"
	
  vk
}
