_start_time=`date +%s.%3N`

echo " exe bash_profile"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:~/bin/:/sbin:/bin"
#echo $LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
#echo $LD_LIBRARY_PATH

alias ll='ls -alF'
alias unzip='unzip -Odos'
alias 7zz="ruby ~/dotfiles/7zz.rb"
#alias scrot="scrot -s -e 'mv \$f /tmp/; upircimage.rb \$f ' "
alias jb='jfbterm'
alias emerge='time emerge -v '
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
alias d='s2'
alias apu='sudo aptitude update'
alias apg='sudo aptitude upgrade'
alias x="startx"

[[ -s "$HOME/dotfiles" ]] && export PATH="$PATH:$HOME/dotfiles"
# /etc/bash.bashrc

export PATH="$PATH:/usr/local/wine-pkg/bin"
export GOROOT=/media/kk/BAK/dev-tools/go
export GOPATH="/home/kk/dev/go"
export QTDIR=/usr/lib/i386-linux-gnu/qt5

which xset && xset r rate 249 60

if [[ -s "$HOME/.rbenv/bin" ]] ; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

export CFLAGS="-march=native -O3"
export CPPFLAGS="-march=native -O3"
export CXXFLAGS="-march=native -O3"

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
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
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

PS1="$ca\H \s $cc $cb \u $cc$c2\w$cc$c3 $cc$c1$(parse_git_branch)$c4 \D{%H:%M:%S} \n▶ $cc"
unset ps1_color user_host

source ~/dotfiles/git-completion.bash

_end_time=`date +%s.%3N`
_processing_time=$(echo $_end_time $_start_time | awk '{print $1 - $2}' )
#echo "Start time: $_start_time"
#echo "End time: $_end_time"
echo "Processing time is: $_processing_time"
uptime
date

  if [[ $TERM == "linux" && $USER != "root" ]]; then
    if [ -x jfbterm ] ; then
      jfbterm;
    fi
  fi

stty -ixon

LANG=zh_CN.UTF-8

alias aa='grep "sshd" /var/log/auth.log'

