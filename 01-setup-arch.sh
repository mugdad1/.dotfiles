#!/bin/bash

# --- Colors ---
Red='\e[0;31m'; Gre='\e[0;32m'; Cya='\e[0;36m'; Whi='\e[0;37m'; End='\e[0m'

echo -e "[${Cya}*${Whi}] Starting System Setup"

# 1. Update and Install All Packages
# Using xargs to pass the whole list to paru at once for speed
echo -e "[${Cya}*${Whi}] Syncing and installing packages from list..."
PKG_LIST="$HOME/.dotfiles/.assets/pkg_lists/pkg_list"

if [ -f "$PKG_LIST" ]; then
    grep -v '^#' "$PKG_LIST" | xargs paru -S --noconfirm --needed
else
    echo -e "[${Red}!${Whi}] pkg_list not found at $PKG_LIST"
    exit 1
fi

# 2. Setup ZSH Plugins
echo -e "[${Gre}*${Whi}] Setting up ZSH plugins..."
ZSH_DIR="$HOME/.zsh"
mkdir -p "$ZSH_DIR"

# Clone helper to prevent "already exists" errors
sync_repo() {
    if [ ! -d "$2" ]; then
        echo -e "➞ Cloning $(basename "$2")..."
        git clone --depth 1 "$1" "$2"
    else
        echo -e "➞ $(basename "$2") is already installed."
    fi
}

sync_repo "https://github.com/zsh-users/zsh-autosuggestions" "$ZSH_DIR/zsh-autosuggestions"
sync_repo "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$ZSH_DIR/zsh-syntax-highlighting"

# 3. Change Shell (Only if not already ZSH)
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    echo -e "[${Cya}*${Whi}] Changing default shell to ZSH (may ask for password)"
    chsh -s /usr/bin/zsh
fi

# 4. Git Global Config
echo -e "[${Gre}*${Whi}] Setting up Git commit template"
if [ -f "$HOME/.gitmessage" ]; then
    git config --global commit.template "$HOME/.gitmessage"
fi

# 5. Transition to Config Script
echo -e "[${Cya}*${Whi}] Running config symlinking script..."
chmod +x ./02-configs.sh
./02-configs.sh

echo -e "\n[${Gre}*${Whi}] 01-setup.sh finished successfully!${End}"
