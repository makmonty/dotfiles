#!/bin/sh

sudo pacman -R nvidia

yay -S \
	nvidia-dkms \
	wayland \
	hyprland \
	hyprlock hypridle wlogout \
	swww waypaper-engine \
	aylurs-gtk-shell \
	xdg-desktop-portal-hyprland \
	xorg-xhost \
	wlr-randr \
	wdisplays \
	wl-clipboard \
	grim slurp swappy \
	nwg-look \
	emote \
	#hyprpaper \
	#wayfire wayfire-plugins-extra wcm wf-config wf-shell \
