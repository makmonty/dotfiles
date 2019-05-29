#!/bin/sh

BASEDIR=$(realpath "$0")

# Install ZSH
sudo apt install zsh
# Make it my default shell
chsh -s $(which zsh)

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

ln -s $BASEDIR/.zshrc ~/.zshrc
ln -s $BASEDIR/.bashrc ~/.bashrc
