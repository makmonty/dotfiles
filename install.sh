#!/bin/sh

BASEDIR=$(dirname "$0")

# Install ZSH
sudo apt install -y zsh curl git
# Make it my default shell
chsh -s $(which zsh)

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

ln -s $BASEDIR/.zshrc ~/.zshrc
ln -s $BASEDIR/.bashrc ~/.bashrc
ln -s $BASEDIR/.p10k.zsh ~/.p10k.zsh

$CUSTOMDIR=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# Install ZSH plugins
git clone https://github.com/zsh-users/zsh-autosuggestions $CUSTOMDIR/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $CUSTOMDIR/plugins/zsh-syntax-highlighting

# Instal themes
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $CUSTOMDIR/themes/powerlevel10k
