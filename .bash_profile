#export RUBY_CFLAGS="-march=native -O3"

echo " exe bash_profile"
if [ -z "$BASHRC_" ] 
then
  sleep 0
  export BASHRC_=" bashrc ed yet"
  source ~/.bashrc
else
  echo $BASHRC_
  sleep 0
fi

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
xset r rate 210 20 &

if [[ -s "$HOME/.rbenv/bin" ]] ; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
export RUBY_CFLAGS="-march=native -O3"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

