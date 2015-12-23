_start_time=`date +%s.%3N`

echo " exe bash_profile"
echo $PATH | grep ruby || export PATH="/home/kk/ruby/bin:$PATH"
export NODE_PATH="/media/kk/SYS2/usr_local/npm/node_modules/"
#echo $LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
#echo $LD_LIBRARY_PATH

alias cb='crystal build'
alias pm='pacman -S'
alias ll='ls -alhF'
alias unzip='echo -Odos ; unzip -Odos'
#alias scrot="scrot -s -e 'mv \$f /tmp/; upircimage.rb \$f ' "
alias jb='jfbterm'
alias emerge='time emerge -v '
alias emergeu='emerge -DNuav --with-bdeps=y @system @world'
alias emergec='emerge -ac'
alias make='time make '
alias grep='grep -i --color=auto'
alias aps='aptitude search'
alias apw='aptitude show'
alias ai='sudo aptitude install'
alias gitdn='git diff --name-only'
alias gitd='git diff --color '
alias gits='git status'
alias s='scr.rb'
alias s1='scr.rb 1'
alias s2='scr.rb 2'
alias s3='scr.rb 3'
alias q='exit'
alias scr='screen -h 260'

alias apu='sudo aptitude update'
alias apg='sudo aptitude upgrade'
alias x="startx"

if [[ -s "$HOME/dotfiles" ]] ; then
  echo $PATH | grep $HOME/dotfiles || export PATH="$PATH:$HOME/dotfiles"
fi

if [[ -s "$HOME/bin" ]] ; then
  echo $PATH | grep $HOME/bin || export PATH="$PATH:$HOME/bin"
fi

if [[ -s "/usr/local/wine-pkg/bin" ]] ; then
  echo $PATH | grep wine-pkg || export PATH="$PATH:/usr/local/wine-pkg/bin"
fi
export GOROOT=/media/kk/BAK/dev-tools/go
export GOPATH="/home/kk/dev/go"
if [[ -s "$GOROOT/bin" ]] ; then
  echo $PATH | grep $GOROOT || export export PATH="$PATH:$GOROOT/bin"
fi
# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/kk/rust/lib"
export QTDIR=/usr/lib/i386-linux-gnu/qt5

which xset && xset r rate 250 80

if [[ -s "$HOME/.rbenv/bin" ]] ; then
  echo $PATH | grep rbenv || export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

export CFLAGS="-march=native -O2"
export CPPFLAGS="-march=native -O2"
export CXXFLAGS="-march=native -O2"

# Enable 256 color capabilities for appropriate terminals

# Set this variable in your local shell config if you want remote
# xterms connecting to this system, to be sent 256 colors.
# This can be done in /etc/csh.cshrc, or in an earlier profile.d script.
#   SEND_256_COLORS_TO_REMOTE=1

# Terminals with any of the following set, support 256 colors (and are local)
local256="$COLORTERM$XTERM_VERSION$ROXTERM_ID$KONSOLE_DBUS_SESSION"

if [ -n "$local256" ] || [ -n "$SEND_256_COLORS_TO_REMOTE" ]; then
  case "$TERM" in
    'xterm') TERM=xterm-256color;;
    'screen') TERM=screen-256color;;
    'Eterm') TERM=Eterm-256color;;
  esac
  export TERM
  export force_color_prompt=yes
  if [ -n "$TERMCAP" ] && [ "$TERM" = "screen-256color" ]; then
    TERMCAP=$(echo "$TERMCAP" | sed -e 's/Co#8/Co#256/g')
    export TERMCAP
  fi
fi
unset local256

echo $BASHRC_
if [ -z "$BASHRC_" ] 
then
  BASH_PRO_=" bash_prof ed yet"
  BASHRC_="bashrc ed yet"
  source ~/.bashrc
else
  echo $BASHRC_
fi
#unset BASH_PRO_
#unset BASHRC_

export WINEDLLOVERRIDES='winemenubuilder.exe=d'

#PS1
parse_git_branch() {
  echo
  #git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
c0="\[\e[30m\]"
c1="\[\e[31m\033[1m\]"
c2="\[\e[32m\033[1m\]"
c3="\[\e[33m\]"
c4="\[\e[34m\]"
c5="\[\e[35m\]"
c6="\[\e[36m\]"
c7="\[\e[37m\]"

cc="\[\e[0m\]" 
ca=`hostname | ruby -e 'print "\e[4#{gets.sum%8+2}m"'` 
cb=`whoami | ruby -e 'print "\e[3#{gets.sum%8+2}m"'` 
#cd=`ip addr | grep "inet " | ruby -e 'print "\e[3#{gets.sum%8+2}m"'` 

PS1="$ca\H \s $cc $cb \u $cc$c2\w$cc $c6 \D{%H:%M:%S} \n▶ $cc"

unset ps1_color user_host

source ~/dotfiles/git-completion.bash

_end_time=`date +%s.%3N`
_processing_time=$(echo $_end_time $_start_time | awk '{print $1 - $2}' )
#echo "Start time: $_start_time"
#echo "End time: $_end_time"
echo "Processing time is: $_processing_time"
uptime 2>/dev/null
date 2>/dev/null

  if [[ $TERM == "linux" && $USER != "root" ]]; then
    if [ -x jfbterm ] ; then
      jfbterm;
    fi
  fi

stty -ixon

#export LANG=C
#LANG=zh_CN.UTF-8

alias aa='grep "sshd" /var/log/auth.log'

