autoload -U compinit promptinit
compinit
promptinit

# This will set the default prompt to the walters theme
prompt walters
autoload -U colors && colors

#命令提示符 {{{
RPROMPT=$(echo '%{\033[31m%}%D %T%{\033[m%}')
PROMPT=$(echo '%{\033[34m%}%M%{\033[32m%}%/
%{\033[36m%}%n %{\033[01;31m%}>%{\033[33m%}>%{\033[34m%}>%{\033[m%} ')
#}}}

#PS1 {{{
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
c0="%{\033[m%}"
c1="%{\033[31m%}"
c2="%{\033[32m%}"
c3="%{\033[33m%}"
c4="%{\033[34m%}"
c5="%{\033[35m%}"
c6="%{\033[36m%}"
c7="%{\033[37m%}"
cc="%{\033[m%}" 
ca=`hostname | ruby -e 'print "%{\033[4#{gets.hash%8+2}m%}"'` 
cb=`whoami | ruby -e 'print "%{\033[3#{gets.sum%8+2}m%}"'` 
PS1="$ca %m %c %/ $cb %n$c2$c3 $(~/.rvm/bin/rvm-prompt v g) $c1$(parse_git_branch)$c4 \n▶ $cc"
unset ps1_color user_host
RPROMPT=$(echo '%{\033[31m%}%D %T%{\033[m%}')
PROMPT=$(echo $PS1)
#}}}

#标题栏、任务栏样式{{{
case $TERM in (*xterm*|*rxvt*|(dt|k|E)term)
   precmd () { print -Pn "\e]0;%n@%M//%/\a" }
   preexec () { print -Pn "\e]0;%n@%M//%/\ $1\a" }
   ;;
esac
#}}}

#关于历史纪录的配置 {{{
#历史纪录条目数量
export HISTSIZE=10000
#注销后保存的历史纪录条目数量
export SAVEHIST=10000
#历史纪录文件
#export HISTFILE=~/.zhistory
#以附加的方式写入历史纪录
setopt INC_APPEND_HISTORY
#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS      
#为历史纪录中的命令添加时间戳      
setopt EXTENDED_HISTORY      

#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
#相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS

#在命令前添加空格，不将此命令添加到纪录文件中
#setopt HIST_IGNORE_SPACE      
#}}}

#每个目录使用独立的历史纪录{{{
cd() {
    builtin cd "$@"                             # do actual cd
    fc -W                                       # write current history  file
    local HISTDIR="$HOME/.zsh_history$PWD"      # use nested folders for history
        if  [ ! -d "$HISTDIR" ] ; then          # create folder if needed
            mkdir -p "$HISTDIR"
        fi
        export HISTFILE="$HISTDIR/zhistory"     # set new history file
    touch $HISTFILE
    local ohistsize=$HISTSIZE
        HISTSIZE=0                              # Discard previous dir's history
        HISTSIZE=$ohistsize                     # Prepare for new dir's history
    fc -R                                       #read from current histfile
}
mkdir -p $HOME/.zsh_history$PWD
export HISTFILE="$HOME/.zsh_history$PWD/zhistory"

function allhistory { cat $(find $HOME/.zsh_history -name zhistory) }
function convhistory {
            sort $1 | uniq |
            sed 's/^:\([ 0-9]*\):[0-9]*;\(.*\)/\1::::::\2/' |
            awk -F"::::::" '{ $1=strftime("%Y-%m-%d %T",$1) "|"; print }'  
}
#使用 histall 命令查看全部历史纪录
function histall { convhistory =(allhistory) |
            sed '/^.\{20\} *cd/i\\' }
#使用 hist 查看当前目录历史纪录
function hist { convhistory $HISTFILE }

#全部历史纪录 top44
function top44 { allhistory | awk -F':[ 0-9]*:[0-9]*;' '{ $1="" ; print }' | sed 's/ /\n/g' | sed '/^$/d' | sort | uniq -c | sort -nr | head -n 44 }

#}}}

#杂项 {{{
#允许在交互模式中使用注释  例如：
#cmd #这是注释
setopt INTERACTIVE_COMMENTS      
      
#启用自动 cd，输入目录名回车进入目录
#稍微有点混乱，不如 cd 补全实用
#setopt AUTO_CD
      
#扩展路径
#/v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word
      
#禁用 core dumps
limit coredumpsize 0

#Emacs风格 键绑定
bindkey -e
#设置 [DEL]键 为向后删除
bindkey "\e[3~" delete-char

#以下字符视为单词的一部分
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'
#}}}

#自动补全功能 {{{
setopt AUTO_LIST
setopt AUTO_MENU
#开启此选项，补全时会直接选中菜单项
#setopt MENU_COMPLETE

autoload -U compinit
compinit

#自动补全缓存
#zstyle ':completion::complete:*' use-cache on
#zstyle ':completion::complete:*' cache-path .zcache
#zstyle ':completion:*:cd:*' ignore-parents parent pwd

#自动补全选项
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

#路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always

#彩色补全菜单 
eval $(dircolors -b) 
export ZLSCOLORS="${LS_COLORS}"
export TERM=xterm-256color
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
#错误校正      
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

#kill 命令补全      
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

#补全类型提示分组 
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
#}}}

##行编辑高亮模式 {{{
# Ctrl+@ 设置标记，标记和光标点之间为 region
zle_highlight=(region:bg=magenta #选中区域 
               special:bold      #特殊字符
               isearch:underline)#搜索时使用的关键字
#}}}

##空行(光标在行首)补全 "cd " {{{
user-complete(){
    case $BUFFER in
        "" )                       # 空行填入 "cd "
            BUFFER="cd "
            zle end-of-line
            zle expand-or-complete
            ;;
        "cd --" )                  # "cd --" 替换为 "cd +"
            BUFFER="cd +"
            zle end-of-line
            zle expand-or-complete
            ;;
        "cd +-" )                  # "cd +-" 替换为 "cd -"
            BUFFER="cd -"
            zle end-of-line
            zle expand-or-complete
            ;;
        * )
            zle expand-or-complete
            ;;
    esac
}
zle -N user-complete
bindkey "\t" user-complete
#}}}

##在命令前插入 sudo {{{
#定义功能 
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    zle end-of-line                 #光标移动到行末
}
zle -N sudo-command-line
#定义快捷键为： [Esc] [Esc]
bindkey "\e\e" sudo-command-line
#}}}
  
#命令别名 {{{
alias -g cp='cp -i'
alias -g mv='mv -i'
alias -g rm='rm -i'
alias -g ls='ls -F --color=auto'
alias -g ll='ls -l'
alias -g grep='grep --color=auto'
alias -g ee='emacsclient -t'

#[Esc][h] man 当前命令时，显示简短说明 
alias run-help >&/dev/null && unalias run-help
autoload run-help

#历史命令 top10
alias top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
#}}}

#路径别名 {{{
#进入相应的路径时只要 cd ~xxx
hash -d WWW="/home/lighttpd/html"
hash -d ARCH="/mnt/arch"
hash -d PKG="/var/cache/pacman/pkg"
hash -d E="/etc/env.d"
hash -d C="/etc/conf.d"
hash -d I="/etc/rc.d"
hash -d X="/etc/X11"
hash -d BK="/home/r00t/config_bak"
#}}}
    
##for Emacs {{{
#在 Emacs终端 中使用 Zsh 的一些设置 不推荐在 Emacs 中使用它
if [[ "$TERM" == "dumb" ]]; then
setopt No_zle
PROMPT='%n@%M %/
>>'
alias ls='ls -F'
fi 	
#}}}

#{{{自定义补全
#补全 ping
zstyle ':completion:*:ping:*' hosts 192.168.128.1{38,} www.g.cn \
       192.168.{1,0}.1{{7..9},}

#补全 ssh scp sftp 等
my_accounts=(
{r00t,root}@{192.168.1.82,192.168.0.1}
sevkme@gmail.com
123@211.148.131.7
)
zstyle ':completion:*:my-accounts' users-hosts $my_accounts
#}}}

####{{{
function calc { echo $(($@)) }
function timeconv { date -d @$1 +"%Y-%m-%d %T" }

# }}}

## END OF FILE #################################################################
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4 
#

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:~/bin/:/sbin:/bin"
export PATH="$PATH:/usr/local/wine-pkg/bin"
export GOPATH="/home/kk/dev/go"
export QTDIR=/usr/lib/i386-linux-gnu/qt5

# some more aliases {{{
alias ap='/media/kk/BAK/dev-tools/Aptana_Studio_3/AptanaStudio3 '
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ls='ls --show-control-chars --color=auto'
alias cdscm='cd /media/kk/Programs/SCM'
alias cdhh='cd /media/kk/Programs/SCM/_HH'
alias cdt='cd /media/Programs/TS'
#alias cdd='cd /home/kk/kk1'
alias cdd="cd /media/kk/Programs/Sevk/3100A"

alias cd1='cd /home/kk/dev/kk-irc-bot'
alias cdg='cd /home/kk/kk1/gb212_sources'
alias cdr='cd /home/kk/rec/rec'
alias apts='aptitude search'
alias aptw='aptitude show'
alias ai='sudo apt-get install'
alias svim='sudo vim'
alias q='exit'
alias minicom='sudo minicom -c on'
alias putty='sudo putty'
#alias miniterm='sudo miniterm.py -b 115200'
alias elnet='/home/kk/kk1/tools/set_time.rb '
alias gitd='git diff --color -w'
alias O='cd ..'
alias gits='git status'
alias vi='vim'
alias ll='ls -alhF --color=auto'
alias l='ls -h --color=auto'
alias irc='irssi -c Ub'
#alias google-chrome='google-chrome --enable-internal-flash'
alias gt='gnome-terminal'
alias nauti='killall nautilus ; LC_ALL=zh_CN.UTF-8 nautilus & '
alias dog='grep -v -E "(^$|^#|^!)"'
alias fbt='sudo fbterm -s 16'

alias ipa='ruby /home/kk/dev/kk-irc-bot/lib/ipwry.rb '
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias frg='ruby /media/kk/BAK/Download/fg/start_fg.rb'
alias pushall='ruby ~/dotfiles/pushall.rb'

alias 7zz="ruby ~/dotfiles/7zz.rb"
#alias scrot="scrot -s -e 'mv \$f /tmp/; upircimage.rb \$f ' "
alias jb='jfbterm'
alias emerge='time emerge -v '
alias make='time make '
alias grep='grep -i --color=auto'
alias ai='sudo aptitude install'
alias gitd='git diff --name-only;read -n 1; git diff --color '
alias gits='git status'
alias irc='irssi -c ub'
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

source ~/.zsh_alias
#}}}

[[ -s "$HOME/dotfiles" ]] && export PATH="$PATH:$HOME/dotfiles"
# /etc/bash.bashrc

export PATH="$PATH:/usr/local/wine-pkg/bin"
export GOPATH="/home/kk/dev/go"
export QTDIR=/usr/lib/i386-linux-gnu/qt5

which xset && xset r rate 230 60

if [[ -s "$HOME/.rbenv/bin" ]] ; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
export RUBY_CFLAGS="-march=native -O3"

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

#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
