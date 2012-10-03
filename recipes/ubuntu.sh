#!/bin/bash
#
# Rails Ready
#
# Author: Josh Frye <joshfng@gmail.com>
# Licence: MIT
#
# Contributions from: Wayne E. Seguin <wayneeseguin@gmail.com>
# Contributions from: Ryan McGeary <ryan@mcgeary.org>
#

ruby_version=$1
ruby_version_string=$2
ruby_source_url=$3
ruby_source_tar_name=$4
ruby_source_dir_name=$5
whichRuby=$6 # 1=source 2=RVM
script_runner=$(whoami)
railsready_path=$7
log_file=$8

#echo "vars set: $ruby_version $ruby_version_string $ruby_source_url $ruby_source_tar_name $ruby_source_dir_name $whichRuby $railsready_path $log_file"

#test if aptitude exists and default to using that if possible
if command -v aptitude >/dev/null 2>&1 ; then
  pm="aptitude"
else
  pm="apt-get"
fi

echo -e "\nUsing $pm for package installation\n"

# Update the system before going any further
echo -e "\n=> Updating system (this may take a while)..."
sudo $pm update >> $log_file 2>&1 \
 && sudo $pm -y upgrade >> $log_file 2>&1
echo "==> done..."

# Install build tools
echo -e "\n=> Installing build tools..."
sudo $pm -y install \
    wget curl build-essential clang \
    bison openssl zlib1g \
    libxslt1.1 libssl-dev libxslt1-dev \
    libxml2 libffi-dev libyaml-dev \
    libxslt-dev autoconf libc6-dev \
    libreadline6-dev zlib1g-dev libcurl4-openssl-dev \
    libtool python-software-properties p7zip-full p7zip-rar libevent-dev libncurses5-dev >> $log_file 2>&1
echo "==> done..."

echo -e "\n=> Installing libs needed for sqlite and mysql..."
sudo $pm -y install libsqlite3-0 sqlite3 libsqlite3-dev libmysqlclient-dev >> $log_file 2>&1
echo "==> done..."

# Install imagemagick
echo -e "\n=> Installing imagemagick (this may take a while)..."
sudo $pm -y install imagemagick libmagick9-dev >> $log_file 2>&1
echo "==> done..."

# Install git-core
echo -e "\n=> Installing git..."
sudo $pm -y install git-core >> $log_file 2>&1
echo "==> done..."

# Install nginx
#echo -e "\n=> Installing nginx..."
#sudo add-apt-repository ppa:nginx/stable >> $log_file 2>&1
#sudo $pm update >> $log_file 2>&1
#sudo $pm -y install nginx >> $log_file 2>&1
#echo "==> done..."
 
# Install postgres
echo -e "\n=> Installing postgres..."
sudo add-apt-repository ppa:pitti/postgresql >> $log_file 2>&1
sudo $pm update >> $log_file 2>&1
sudo $pm -y install postgresql libpq-dev postgresql-contrib >> $log_file 2>&1
echo "==> done..."

# Install node
echo -e "\n=> Installing node..."
sudo add-apt-repository ppa:chris-lea/node.js >> $log_file 2>&1
sudo $pm update >> $log_file 2>&1
sudo $pm -y install nodejs >> $log_file 2>&1
echo "==> done..."

# Install desenv env
echo -e "\n=> Installing desenv env..."
sudo $pm -y install vim zsh ruby-dev rake exuberant-ctags ack-grep tmux >> $log_file 2>&1
#janus
#curl -Lo- https://bit.ly/janus-bootstrap | bash
#git clone https://github.com/alextakitani/dotjanus ~/.janus 
#cd ~/.janus
#git submodule update --init
#cd ~
#zsh
#curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash
#dotfiles
#git clone https://github.com/alextakitani/dotfiles ~/dotfiles
#ruby ~/dotfiles/install.rb
#tmux 1.6
#curl -L http://ufpr.dl.sourceforge.net/project/tmux/tmux/tmux-1.6/tmux-1.6.tar.gz  | tar -xvz
#cd tmux-1.6
#./configure && make && sudo make install
echo "==> done..."
