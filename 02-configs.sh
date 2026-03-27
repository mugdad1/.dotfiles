#!/bin/bash
Red='\e[0;31m'; Gre='\e[0;32m'; Whi='\e[0;37m'; 

echo -e "[${Gre}*${Whi}] Setting up config files"
cd ~/.dotfiles || exit

# --- 1. Cleanup ---
echo -e "➞ [${Red}*${Whi}] Removing existing config directories to prevent conflicts"
# This clears out existing directories in ~/.config that match folders in our dotfiles
for dir in $(ls -d .config/*/ 2>/dev/null | sed 's|.config/||' | sed 's|/||'); do
    if [ -d "$HOME/.config/$dir" ]; then
        rm -rf "$HOME/.config/$dir"
    fi
done

# --- 2. Final Stow ---
echo -e "➞ [${Gre}*${Whi}] Symlinking configurations via GNU Stow"

# Ensure we are stowing the contents of the .config folder into the system's ~/.config
stow -v -R -t ~/.config .config

# Stow home files if they exist (e.g., .zshrc, .bashrc from a .home folder)
if [ -d ".home" ]; then
    echo -e "➞ [${Gre}*${Whi}] Symlinking home directory files"
    stow -v -R -t ~ .home
fi

echo -e "[${Gre}*${Whi}] Finished deployment. Beansprout is ready."
