Red='\e[0;31m';
Gre='\e[0;32m';
Cya='\e[0;36m';
Whi='\e[0;37m';

# Synchronize package databases
echo -e "[${Red}*${Whi}] Updating system.."
paru -Syu

# Install pkgs
echo -e "[${Red}+${Whi}] Installing packages"
for pkg in $(cat ~/.dotfiles/.assets/pkg_lists/pkg_list)
do
	paru -S --noconfirm --needed $pkg
done

# Setup ZSH
echo -e "[${Gre}*${Whi}] Setting up ZSH plugins"
mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# Change shell for root
echo -e "[${Red}*${Whi}] Changing shell for user"
sudo chsh -s /usr/bin/zsh

# Clone GTK theme(s) and icons
echo -e "[${Gre}*${Whi}] Cloning GTK theme and icons"
sudo git clone https://codeberg.org/tplasdio/numigsur-icon-theme.git /usr/share/icons/numigsur-icon-theme
sudo git clone https://github.com/EliverLara/Nordic /usr/share/themes/Nordic

# Change default commit message for git
echo -e "[${Gre}*${Whi}] Cloning default commit message for git"
git config --global commit.template ~/.gitmessage

chmod +x ./02-configs.sh
./02-configs.sh
