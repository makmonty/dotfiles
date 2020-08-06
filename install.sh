#!/bin/sh
FULLPATH=$(readlink -f "$0")
BASEDIR=$(dirname "$FULLPATH")

# Install ZSH
sudo apt install -y zsh curl git
# Make it my default shell
chsh -s $(which zsh)

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

ln -s $BASEDIR/.zshrc ~/.zshrc
ln -s $BASEDIR/.bashrc ~/.bashrc
ln -s $BASEDIR/.p10k.zsh ~/.p10k.zsh
ln -s $BASEDIR/.vimrc ~/.vimrc

CUSTOMDIR=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# Install ZSH plugins
cd $BASEDIR
git submodule init
git submodule update
ln -s $BASEDIR/plugins/zsh-autosuggestions $CUSTOMDIR/plugins/zsh-autosuggestions
ln -s $BASEDIR/plugins/zsh-syntax-highlighting $CUSTOMDIR/plugins/zsh-syntax-highlighting

# Instal themes
ln -s $BASEDIR/themes/powerlevel10k $CUSTOMDIR/themes/powerlevel10k
