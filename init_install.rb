#install from mini.iso
#

a = "
xfce4-terminal
vim
git
xfonts-intl-chinese
build-essential
"
a.each_line do |x|
  system "apt-get install #{x}"
end

mkdir -p .irssi/scripts/autorun
cd .irssi/scripts/autorun
wget http://scripts.irssi.org/scripts/usercount.pl
wget http://scripts.irssi.org/scripts/nickcolor.pl
wget http://scripts.irssi.org/scripts/beep_beep.pl

wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
