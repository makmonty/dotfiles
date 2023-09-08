#!/bin/sh

yay -S \
	nvidia nvidia-utils vulkan-tools \
	sddm \
	xfce4 awesome-git \
	xdg-desktop-portal-gtk \
	network-manager-applet nm-connection-editor \
	kitty blueman polkit lxsession-gtk3 lxappearance firefox \
	gthumb \
	ttf-meslo ttf-nerd-fonts-symbols \
	papirus-icon-theme \

sudo systemctl enable sddm
sudo systemctl start sddm
