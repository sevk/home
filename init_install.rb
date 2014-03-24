#install from mini.iso
#

a = "
xfce4-terminal
vim
git
xfonts-intl-chinese
build-essential
irssi
"
if system('which apt-get')
  a.each_line do |x|
    system "apt-get install #{x}"
  end
end

"
mkdir -p .irssi/scripts/autorun
cd .irssi/scripts/autorun
wget http://scripts.irssi.org/scripts/usercount.pl
wget http://scripts.irssi.org/scripts/nickcolor.pl
wget http://scripts.irssi.org/scripts/beep_beep.pl

cd
wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash

cd ~/dotfiles/vim/bundle/
git clone https://github.com/gmarik/vundle.git --depth=1

git config alias.pullall '!f(){ git pull "$@" && git submodule update --init --recursive; }; f'
".each_line {|x|
  puts system x 
}
