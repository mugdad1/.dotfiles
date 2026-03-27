#!/bin/bash
Red='\e[0;31m'; Gre='\e[0;32m'; Cya='\e[0;36m'; Whi='\e[0;37m'; End='\e[0m'

echo -e "[${Cya}*${Whi}] Installing River 0.4.1 + Beansprout Stack..."

# Your original package list installation (KEEPING THIS)
PKG_LIST="$HOME/.dotfiles/.assets/pkg_lists/pkg_list"
grep -v '^#' "$PKG_LIST" | xargs paru -S --noconfirm --needed

# Install Zig (Required to build Beansprout if not in your pkg_list)
sudo pacman -S --needed zig wayland-protocols

# --- New: Build Beansprout from Source ---
echo -e "[${Gre}*${Whi}] Building Beansprout WM..."
if [ ! -d "/tmp/beansprout" ]; then
    git clone https://codeberg.org/river/beansprout /tmp/beansprout
fi

cd /tmp/beansprout
zig build -Doptimize=ReleaseSafe
sudo cp zig-out/bin/beansprout /usr/local/bin/

# Return to your script directory
cd - > /dev/null

# Proceed to your configs
chmod +x ./02-configs.sh
./02-configs.sh
