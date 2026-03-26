#!/bin/bash
Red='\e[0;31m'; Gre='\e[0;32m'; Cya='\e[0;36m'; Whi='\e[0;37m'; End='\e[0m'

echo -e "[${Cya}*${Whi}] Installing River 0.4.0 Lua Stack..."
PKG_LIST="$HOME/.dotfiles/.assets/pkg_lists/pkg_list"

# Install everything including the new Lua manager
grep -v '^#' "$PKG_LIST" | xargs paru -S --noconfirm --needed

# Install any required Lua hits for the manager
sudo luarocks install lgi # Common dependency for Wayland/Lua

chmod +x ./02-configs.sh
./02-configs.sh
