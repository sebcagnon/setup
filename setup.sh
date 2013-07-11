#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup.

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git-core
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
chsh -s /bin/zsh
