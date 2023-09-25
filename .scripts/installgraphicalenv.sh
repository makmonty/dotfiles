#!/bin/sh

yay -S \
	nvidia nvidia-utils vulkan-tools \
	sddm chili-sddm-theme \
	xfce4 awesome-git \
	xdg-desktop-portal-gtk \
	network-manager-applet nm-connection-editor \
	kitty blueman polkit lxsession-gtk3 lxappearance gnome-tweaks \
	firefox \
	gthumb \
	dunst \
	ttf-meslo ttf-nerd-fonts-symbols \
	papirus-icon-theme \
	cups ghostscript \
	gammastep \

sudo systemctl enable sddm
sudo systemctl start sddm
