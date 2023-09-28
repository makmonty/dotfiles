#!/bin/sh

sudo pacman -R nvidia

yay -S \
	nvidia-dkms \
	wayland \
	waylock swayidle waybar wlogout \
	hyprland-nvidia hyprpaper \
	xdg-desktop-portal-hyprland \
	xorg-xhost \
	wlr-randr \
	wdisplays \
	wl-clipboard \
	#wayfire wayfire-plugins-extra wcm wf-config wf-shell \
