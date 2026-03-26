#!/bin/sh

# Environment
dbus-update-activation-environment --all &

# UI Components (Kill then start)
pkill mako; mako &
pkill waybar; waybar &
pkill nm-applet; nm-applet --indicator &
pkill wlsunset; wlsunset -T 4500 &

# Authentication
pkill polkit-gnome; /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Wallpaper
pkill swaybg; swaybg -i ~/.dotfiles/.assets/wallpapers/warrior_nord.jpg -m fill &

# Misc
brightnessctl set 20%
~/.config/scripts/updates.sh &
