#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

# Able to exit when failing to install a package
set -e
#install dependencies
echo -e "${BLUE} Starting installation process ${NC}"
sudo apt-get -y -f install || (echo -e "${RED} Failed setup ${NC}" && exit 1)
sudo apt-get -y update
echo -e "${GREEN} Setup Complete ${NC}"
#install pip packages
APT_GET_PACKAGES="git emacs-nox gnome-tweaks zsh terminator tmux neofetch nautilus vim tree steam dconf-editor htop curl"
echo -e "${CYAN}Using pip to install $PIP_PACKAGES ${NC}"
for i in $APT_GET_PACKAGES; do
    sudo apt-get -y install $i || (echo -e "${RED}Failed to install $i${NC}" && exit 1)
    echo -e "${GREEN}Installed $i${NC}"
done
#installing chrome
echo "Installing Chrome"
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm goo* #cleaning up
#installing discord
echo "Installing Discord"
cd ~/Downloads
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo dpkg -i discord.deb
rm discord.deb

#install oh my zsh
yes | sudo sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#install plugins
sudo git clone https://github.com/zdharma/fast-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sudo sed -i ../.zshrc -e '71s!plugins=(git)!plugins=(git fast-syntax-highlighting zsh-autosuggestions)!'
#install themes
cd ../.oh-my-zsh/custom/themes
rm -f *
rm -rf *
sudo git clone https://github.com/denysdovhan/spaceship-prompt ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt
sudo ln -sf "spaceship-prompt/spaceship.zsh-theme" "spaceship.zsh-theme"
sudo sed -i ~/.zshrc -e '11s!ZSH_THEME="robbyrussell"!ZSH_THEME="spaceship"!'
sudo chsh -s $(which zsh) #change default shell
source ~/.zshrc #done with zsh

#install gotop
#cd ~/Downloads
#git clone --depth 1 https://github.com/cjbassi/gotop
#cd gotop/scripts/
#./download.sh
#sudo mv gotop ~/../../usr/local/bin
#cd ~/Downloads
#rm -rf gotop #cleaning up
