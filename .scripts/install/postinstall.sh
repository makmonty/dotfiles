#!/bin/sh

#localectl set-keymap es

# AUR
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Services

# Network
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

# Network Time Protocol
sudo systemctl enable ntpd.service
sudo systemctl start ntpd.service

sudo systemctl enable ntpdate.service
sudo systemctl start ntpdate.service
