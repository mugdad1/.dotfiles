#!/bin/bash

# Colors
Red='\e[0;31m'
Gre='\e[0;32m'
Whi='\e[0;37m'
End='\e[0m'

echo -e "[${Gre}*${Whi}] Setting up config files"

# Ensure we are in the dotfiles directory
DOTFILES="$HOME/.dotfiles"
cd "$DOTFILES" || { echo "Dotfiles dir not found"; exit 1; }

# 1. Handle .config directory
echo -e "➞ [${Red}*${Whi}] Cleaning and Symlinking .config"
if [ -d ".config" ]; then
    # Create ~/.config if it doesn't exist
    mkdir -p ~/.config
    
    # Run stow from the dotfiles root. 
    # This will link everything inside .dotfiles/.config/* into ~/.config/
    stow -v -R -t ~/.config .config
fi

# 2. Handle .home directory
echo -e "➞ [${Gre}*${Whi}] Cleaning and Symlinking .home"
if [ -d ".home" ]; then
    # This links the contents of .home (like .bashrc, .zshrc) directly into ~
    stow -v -R -t ~ .home
fi

echo -e "[${Gre}*${Whi}] Finished setting up configs${End}"
