#!/bin/sh

#localectl set-keymap es

# AUR
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Services
#sudo systemctl start dhcpcd
sudo systemctl start NetworkManager
