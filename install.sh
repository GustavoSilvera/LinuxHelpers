#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

# Able to exit when failing to install a package
set -e

#preprocess installation
echo -e "${CYAN}Starting installation process ${NC}"
sudo apt --fix-broken -y install || (echo -e "${RED}Failed to fix broken install ${NC}" && exit 1)
APT_GET_SETUP="install update autoremove upgrade autoclean"
for i in $APT_GET_SETUP; do
	sudo apt-get -y $i || (echo -e "${RED}Failed $i ${NC}" && exit 1)
    	echo -e "${GREEN}Successfull $i ${NC}"
done
echo -e "${GREEN}Setup Complete ${NC}"

#install apt-get packages
APT_GET_PACKAGES="git emacs-nox gnome-tweaks zsh terminator tmux neofetch nautilus vim tree steam dconf-editor htop curl gcc"
echo -e "${CYAN}Using apt-get to install $APT_GET_PACKAGES ${NC}"
for i in $APT_GET_PACKAGES; do
    	sudo apt-get -y install $i || (echo -e "${RED}Failed to install $i${NC}" && exit 1)
	echo -e "${GREEN}Installed $i${NC}"
done
echo -e "${GREEN}Successfully installed all apt-get packages${NC}"

#install .deb packages
DEB_PACKAGES="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb https://discordapp.com/api/download?platform=linux&format=deb"
echo -e "${CYAN}Using downloading and installing $DEB_PACKAGES ${NC}"
for i in $DEB_PACKAGES; do
    	wget -O install_deb.deb $i || (echo -e "${RED}Failed to download $i ${NC}" && exit 1)
	sudo dpkg -i install_deb.deb || (echo -e "${RED}Failed to install $i ${NC}" && exit 1)
	rm install_deb.deb
	sudo apt --fix-broken install || (echo -e "${RED}Failed to fix broken install ${NC}" && exit 1)
	echo -e "${GREEN}Installed $i ${NC}"
done
echo -e "${GREEN}Successfully installed all deb packages${NC}"

#install oh my zsh
#3yes | sudo sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#install plugins
#sudo git clone https://github.com/zdharma/fast-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
#sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#sudo sed -i ../.zshrc -e '71s!plugins=(git)!plugins=(git fast-syntax-highlighting zsh-autosuggestions)!'
#install themes
#cd ../.oh-my-zsh/custom/themes
#rm -f *
#rm -rf *
#sudo git clone https://github.com/denysdovhan/spaceship-prompt ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt
#sudo ln -sf "spaceship-prompt/spaceship.zsh-theme" "spaceship.zsh-theme"
#sudo sed -i ~/.zshrc -e '11s!ZSH_THEME="robbyrussell"!ZSH_THEME="spaceship"!'
#sudo chsh -s $(which zsh) #change default shell
#source ~/.zshrc #done with zsh

#install gotop
#cd ~/Downloads
#git clone --depth 1 https://github.com/cjbassi/gotop
#cd gotop/scripts/
#./download.sh
#sudo mv gotop ~/../../usr/local/bin
#cd ~/Downloads
#rm -rf gotop #cleaning up
