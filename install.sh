#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

# Exit immediately when failing to install a package
set -e

HOME="/home/$USER" # get home dir ~

mkdir -p setup_files # do everything in container
cd setup_files

# install default programs through apt
echo -e "${CYAN}Starting apt installation process ${NC}"
brew update
APT_PKGS=(
    "git"
    "tree"
    "tmux"
    "neofetch"
    "htop"
    "emacs-nox"
	"terminator"
)
for i in ${APT_PKGS[*]} ; do
    sudo apt install -y $i || (echo -e "${RED}Failed installing $i ${NC}" && exit 1)
    echo -e "${GREEN}Successfully installed $i ${NC}"
done

# install packaged through git
mkdir -p git_repos
cd git_repos
# insert username/reponame
GIT_REPOS=(
    "ohmyzsh/ohmyzsh"
    "zsh-users/zsh-autosuggestions"
    "zdharma/fast-syntax-highlighting"
)
for userrepo in ${GIT_REPOS[*]} ; do
    username=$(cut -d'/' -f1 <<<"${userrepo}")
    reponame=$(cut -d'/' -f2 <<<"${userrepo}")
    if [ ! -d $reponame ] # only clone once
    then
        git clone "https://github.com/${username}/${reponame}"
    fi
done
# install individual packages:

echo -e "${CYAN}Installing zsh & plugins${NC}"
# install zsh
if [ ! -d "${HOME}/.oh-my-zsh/" ]
then 
    bash ohmyzsh/tools/install.sh # only run script once
fi
# install zsh plugins
if [ ! -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]
then
    PLUGINS_DIR="${HOME}/.oh-my-zsh/custom/plugins/"
    cp -r zsh-autosuggestions ${PLUGINS_DIR}
    cp -r fast-syntax-highlighting ${PLUGINS_DIR}
    # add plugins to .zshrc under "plugins=(git)"
    sed -ie "s/plugins=(git)/\plugins=(git)\nplugins=(zsh-autosuggestions fast-syntax-highlighting)/" $HOME/.zshrc
fi
cd .. # back to main dir