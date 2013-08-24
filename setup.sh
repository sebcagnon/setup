#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup.

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git-core
sudo apt-get install -y curl
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

# install programming dependencies
sudo apt-get install -y python-software-properties python g++ make

# installing ctafconf environment
cd
mkdir -p ~/.config
git clone git://github.com/ctaf42/ctafconf.git
cd ctafconf
./bin/ct-installconf
sed "s/var_set ctafconf_profiles.*/var_set ctafconf_profiles 'aldebaran'/" -i ~/.config/ctafconf/user-profile.sh
cd

# changing main terminal to zsh
sudo apt-get install -y zsh
sudo chsh -s /usr/bin/zsh ubuntu

# installing Heroku
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
heroku login
ssh-keygen -t rsa
heroku keys:add

# git config
git config --global user.name "Sebastien Cagnon"
git config --global user.email cagnonsebastien@gmail.com

# adding node into .zshrc.user
echo 'alias node="env NODE_NO_READLINE=1 rlwrap node"
alias node_repl="node -e \"require('repl').start({ignoreUndefined: true})\""
export NODE_DISABLE_COLORS=1
if [ -s ~/.nvm/nvm.sh ]; then
NVM_DIR=~/.nvm
    source ~/.nvm/nvm.sh
    nvm use v0.10.12 &> /dev/null # silence nvm use; needed for rsync
fi' >> .zshrc.user