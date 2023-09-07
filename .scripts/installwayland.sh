#!/bin/sh

sudo pacman -R nvidia

yay -S \
	nvidia-dkms \
	wayland \
	swaylock swayidle waybar wlogout \
	hyprland-nvidia hyprpaper \
	#wayfire wayfire-plugins-extra wcm wf-config wf-shell \
