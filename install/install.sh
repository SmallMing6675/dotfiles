#!/bin/bash
#=============================================
# This scripts simply installs all the required packages
# and stows all the config files in the ~/dotfiles directory
# back to the home directory. 
# Note that this script only works with arch or
# arch based distros.
#=============================================
cd ~/dotfiles

BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BRIGHT_BLACK='\033[1;30m'
BRIGHT_RED='\033[1;31m'
BRIGHT_GREEN='\033[1;32m'
BRIGHT_YELLOW='\033[1;33m'
BRIGHT_BLUE='\033[1;34m'
BRIGHT_PURPLE='\033[1;35m'
BRIGHT_CYAN='\033[1;36m'
BRIGHT_WHITE='\033[1;37m'
NC='\033[0m' # No Color

install_yay() {
    echo -e "${YELLOW}Yay not found. Installing yay..${NC}"
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
}

if ! command -v yay &> /dev/null; then
    install_yay
fi

if ! command -v stow &> /dev/null; then
    sudo pacman -S stow
fi


echo -e "${CYAN}Installing essential packages...${NC}"
packages=(\
#essential packages
\
git \
bash \
man-db \
fish \
kitty \
neovim \
vim \
starship \
\
#hyprland
hyprland \
hyprpicker \
swaybg \
waybar-git \
rofi \
brightnessctl \
librewolf-bin \
pavucontrol \
pipewire \
wl-clipboard \
grim \
slurp \
\
#terminal utils
eza \
fd \
neofetch \
lazygit \
ripgrep \
zoxide \
\
#fonts
ttf-jetbrains-mono \
ttf-jetbrains-mono-nerd)

yay -S --needed --noconfirm "${packages[@]}"

echo -e "${PURPLE}Updating Config...${NC}"
cd ~/dotfiles/
stow .

echo -e "${GREEN}Dotfiles installation completed!${NC}"
