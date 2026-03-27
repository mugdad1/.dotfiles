dbus-update-activation-environment --all
killall mako
mako &

killall waybar
waybar &

killall twenty
twenty --init &

killall polkit-gnome-authentication-agent-1
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

killall nm-applet
nm-applet --indicator &

killall wlsunset
wlsunset -T 4500 &
brightnessctl set 20%
swaybg -i ~/.dotfiles/.assets/wallpapers/warrior_nord.jpg -m fill

~/.config/scripts/updates.sh
