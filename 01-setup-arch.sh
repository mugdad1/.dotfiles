#!/bin/bash
Red='\e[0;31m'; Gre='\e[0;32m'; Cya='\e[0;36m'; Whi='\e[0;37m'; End='\e[0m'

echo -e "[${Cya}*${Whi}] Installing River 0.4.1 + Beansprout..."
PKG_LIST="$HOME/.dotfiles/.assets/pkg_lists/pkg_list"

# Install your existing list
grep -v '^#' "$PKG_LIST" | xargs paru -S --noconfirm --needed

# Build Beansprout from Source
echo -e "[${Gre}*${Whi}] Building Beansprout WM..."
sudo pacman -S --needed zig wayland-protocols wlroots libxkbcommon pixman

if [ ! -d "/tmp/beansprout" ]; then
    git clone https://codeberg.org/beansprout/beansprout /tmp/beansprout
fi

cd /tmp/beansprout
zig build -Doptimize=ReleaseSafe
sudo cp zig-out/bin/beansprout /usr/local/bin/
cd - > /dev/null

chmod +x ./02-configs.sh
./02-configs.sh
