#!/bin/sh

sudo pacman -R nvidia

yay -S \
	nvidia-dkms \
	wayland \
	waylock swayidle waybar wlogout \
	hyprland-nvidia \
	swww \
	aylurs-gtk-shell \
	xdg-desktop-portal-hyprland \
	xorg-xhost \
	wlr-randr \
	wdisplays \
	wl-clipboard \
	grim slurp swappy \
	#hyprpaper \
	#wayfire wayfire-plugins-extra wcm wf-config wf-shell \
