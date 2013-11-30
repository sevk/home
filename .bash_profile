
echo " exe bash_profile"

alias jb='jfbterm'
alias emerge='time emerge -v '
alias grep='grep -i --color=auto'
alias scrot="scrot -s -e 'mv \$f /tmp/'"
alias aps='aptitude search'
alias apw='aptitude show'
alias ai='sudo aptitude install'
alias gitd='git diff'
alias gits='git status'
alias irc='irssi -c ub'
alias s='scr.rb'
alias s1='scr.rb 1'
alias s2='scr.rb 2'
alias s3='scr.rb 3'

[[ -s "$HOME/dotfiles" ]] && export PATH="$PATH:$HOME/dotfiles"
export PATH="$PATH:/media/kk/BAK/dev-tools/jruby-1.7.4/bin"

[ -x /bin/xset ] && xset r rate 230 60

if [[ -s "$HOME/.rbenv/bin" ]] ; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
export RUBY_CFLAGS="-march=native -O3"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

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

if [ -z "$BASHRC_" ] 
then
  BASHRC_=" bashrc ed yet"
  source ~/.bashrc
else
  echo $BASHRC_
fi

export WINEDLLOVERRIDES='winemenubuilder.exe=d'

#PS1
if [[ ${EUID} == 0 ]] ; then
  ps1_color="\[\033[0;31m\]";
  user_host="\h"
else
  ps1_color="\[\033[0;35m\]";
  user_host="\[\033[0;36m\]\u\[\033[0;31m\]@\[\033[0;32m\]\h"
fi
#export PS1="$ps1_color\342\224\214\342\224\200[\\$]\342\224\200[$(pwd)$user_host$ps1_color]\342\224\200[\[\033[32m\]\w"'$(__git_ps1 "(%s)")'"$ps1_color]\342\224\200[\[\033[8m\]\t$ps1_color]\n$ps1_color\342\224\224\342\224\200>\[\033[0m\]"
unset ps1_color user_host

alias ipa='ruby /home/kk/dev/kk-irc-bot/lib/ipwry.rb '
source dotfiles/git-completion.bash 

if [[ ! ${DISPLAY} && ${XDG_VTNR} == 8 ]]; then
  exec awesome
  echo 1 ;
else
  echo 2;
  if [[ $TERM == "linux" && $USER != "root" ]]; then
    jfbterm;
  fi
fi
