#!/bin/sh

yay -S \
	sddm chili-sddm-theme \
	xfce4 awesome-git \
	thunar thunar-archive-plugin file-roller \
	xdg-desktop-portal-gtk \
	network-manager-applet nm-connection-editor \
	kitty blueman polkit lxsession-gtk3 lxappearance gnome-tweaks \
	firefox \
	gthumb \
	dunst \
	pavucontrol \
	galculator mousepad \
	system-config-users \
	ttf-meslo ttf-nerd-fonts-symbols \
	papirus-icon-theme \
	cups ghostscript \
	gammastep

sudo systemctl enable sddm
sudo systemctl start sddm
