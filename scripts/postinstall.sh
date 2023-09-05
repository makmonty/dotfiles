#!/bin/sh

#localectl set-keymap es

# AUR
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S ttf-meslo ttf-nerd-fonts-symbols awesome-git hyprland-nvidia

# Services
#sudo systemctl start dhcpcd
sudo systemctl start NetworkManager
sudo systemctl start sddm
