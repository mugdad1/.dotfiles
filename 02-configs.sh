Red='\e[0;31m';
Gre='\e[0;32m';
Whi='\e[0;37m';

echo -e "[${Gre}*${Whi}] Setting up config files"

echo -e "➞ [${Red}*${Whi}] Removing existing config directories"

cd ~/.dotfiles

# Remove existing .config directories
for dir in $(find .config -maxdepth 1 -mindepth 1 -type d | sed 's|.*/||')
do
	rm -rf ~/.config/$dir
done

# Remove existing .home directories
for dir in $(find .home -maxdepth 1 -mindepth 1 -type d | sed 's|.*/||')
do
	rm -rf ~/$dir
done

echo -e "➞ [${Gre}*${Whi}] Symlinking directories in .config"

cd ~/.dotfiles/.config
for dir in $(find . -maxdepth 1 -mindepth 1 -type d | sed 's|.*/||')
do
	stow -t ~/.config/$dir $dir
done

echo -e "➞ [${Gre}*${Whi}] Symlinking directories in .home"

cd ~/.dotfiles
stow -t ~ .home

echo -e "[${Gre}*${Whi}] Finished setting up configs"
