unset LANG
unset LC_ALL

export BASH_SILENCE_DEPRECATION_WARNING=1
export TERM='xterm-256color'
export HISTSIZE=8192
export HISTTIMEFORMAT='%F %T '
export HISTIGNORE="c:l:ls:ll:lc:cl:p:history:cd:u:m:mc:mcm"
export HISTCONTROL=ignoredups
export GPG_TTY=$(tty)
export LS_COLORS="ow=01;34;04"
export HOST=$(hostname -s)
export ARCH=$(arch)

alias a='alias'
alias clear='clear -x'
alias c='clear'
alias ccd='cd'
alias d='cd'
alias f='file'
alias h='history'
alias rm='rm -i'
alias t='type'
alias x="awk '{printf \"\\033[31m%-6s\\033[0m %s\\n\", NR, \$0}'"
alias m='make'
alias mc='make clean'
alias mcm='make clean && make'
alias mi='make -j install'
alias mj='make -j'
alias mr='make run'
alias mv1='make VERBOSE=1'
alias g='git'
alias gl='git log --oneline --decorate --all --graph'
alias gs='git status'
alias gd='git diff'
alias gt='git difftool'
alias gc='git commit -a -m'
alias sc='screen -U'
alias v='vim'
alias vi='vim'
alias iv='vim'
alias ni='nvim'
alias in='nvim'
alias z='tar zxvf'
alias ls='ls --color=auto'
alias l='ls -l'
alias ll='ls -al'
alias lll='ls -alh'
alias lt='ls -altrh'
alias lT='ls -alth'
alias cl='clear && ls -l'
alias lc='clear && ls -l'
alias cls='clear && ls'
alias grep='grep --colour=auto'
alias tf='tail -f'
alias p='cd .. && clear && ls -l'
alias s='ssh'
alias ssh8='ssh -L 8888:localhost:8888'
alias rp='cd $(realpath .)'
alias shortps1='export PROMPT_DIRTRIM=3'
alias hex='printf "0x%x\n"'
alias dec='printf "%d\n"'
alias now='echo $(date +"%Y%m%d-%H%M%S")'
alias hostnow='echo $HOST-$(date +"%Y%m%d-%H%M%S")'

if [ ${DOCKERIMG} ]; then
export PS1='\[\033[01;31m\]${HOSTNAME}\[\033[00m\]:\[\033[01;38;5;208m\]\w\[\033[00m\]\$ '
else
export PS1='\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;38;5;208m\]\w\[\033[00m\]\$ '
fi

p2() {
for i in {0..63}
do
  printf "%2u : %u 0x%x\n" "$i" "$((1 << $i))" "$((1 << $i))"
done
}

sw() {
s=0
while [[ 1 ]]; do
  echo $s "secs"
  sleep 1
  s=$[$s+1];
done
}

coloransi() {
PREFIX='\033[01;'
RESET='\033[0m'
for i in {30..37}
do
  for j in {40..47}
  do
    echo -en "${PREFIX}${i};${j}m ${i};${j} ${RESET}"
  done
  echo
done
}

color256() {
for i in {0..255}
do printf "\x1b[38;5;${i}m%-5i\x1b[0m" $i
  if [ $((i % 16)) == 15 ]; then
  echo
  fi
done
echo
}

colortrue() {
awk 'BEGIN{
  s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
  for (colnum = 0; colnum<77; colnum++) {
    r = 255-(colnum*255/76);
    g = (colnum*510/76);
    b = (colnum*255/76);
    if (g>255) g = 510-g;
    printf "\033[48;2;%d;%d;%dm", r,g,b;
    printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
    printf "%s\033[0m", substr(s,colnum+1,1);
  }
printf "\n";
}'
}

bin() {
  if [[ $1 == 0x* ]]; then
    hex="${1#0x}"
    dec=$((16#$hex))
  else
    dec=$1
  fi
  binary=$(echo "obase=2; $dec" | bc)

  len=${#binary}
  mod=$((len % 4))
  if [ $mod -ne 0 ]; then
    for ((i=0; i<4-mod; i++)); do
      binary="0$binary"
    done
  fi
  echo $binary | sed 's/\(....\)/\1 /g'
}

bdf() {
  if [ "$1" ]; then
    local gpu=$(($1 + 1))
    lspci -d 10de: | awk '{print $1}' | sed -n ${gpu}p
  else
    lspci -d 10de: | awk '{print $1}'
  fi
}

bar0() {
  region=$(lspci -vv -d 10de: | grep 'Region 0' | awk '{print $5}')
  printf "0x%s\n" $region
}

gi() {
  if [[ $1 == "tpush" ]]; then
    git push "${@:2}"
  elif [[ $1 == "tpull" ]]; then
    git pull "${@:2}"
  fi
}

howlong() {
  dir="."
  if [ -n "$1" ]; then
    dir=$1/*
  fi
  if [ -n "$2" ]; then
    dir=$1/*.$2
  fi
  file0=$(ls -t  $dir | tail -n 1)
  file1=$(ls -tr $dir | tail -n 1)
  time0=$(stat -c %Y "$file0")
  time1=$(stat -c %Y "$file1")
  time01=$((time1 - time0))
  echo "$(date -d@$time01 -u +%H:%M:%S)"
}

title() {
  CHIP=$(gpu chip 0 2>/dev/null)
  if [ -z "$CHIP" ]; then
    echo -ne "\033]0;${HOST} ${ARCH}\007"
  else
    echo -ne "\033]0;${HOST} $CHIP ${ARCH}\007"
  fi
}

title

