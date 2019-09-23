#!/bin/bash

#1º install zsh
#2º install oh my zsh
#3º install powerlevel10k
#4º install nerdfonts/hack
#5º install zsh autocomplete
#6º install zsh highlighting

RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
BOLD=$(printf '\033[1m')
RESET=$(printf '\033[m')


echo "
This script will install:
 ${RED}1º ZSH		
 ${YELLOW}2º Oh-myzsh
 ${BLUE}3º powerlevel9k
 ${GREEN}4º Nerd-fonts

$RED Addicional resources may be installed.
"

read -r -p "${RED}Are you sure you want to continue? [y/N]${RESET}" confirmation
if [ "$confirmation" != y ] && [ "$confirmation" != Y ]; then
  echo "Install cancelled"
  exit
fi

GIT_INSTALLED=""
ZSH_INSTALLED=""
CURL_INSTALLED=""

GIT_INSTALLED=$(which git)
ZSH_INSTALLED=$(which zsh)
CURL_INSTALLED=$(which curl)

#install git
echo -e "${GREEN}--------------GIT---------------"
if test -z "$GIT_INSTALLED"; then
	echo  "${GREEN}Installing git."
	sudo apt install git
else 
	echo "${RED}Git already installed."
fi
echo -e "${RED}--------------GIT---------------\n"

#install curl
echo -e "${GREEN}--------------CURL---------------"
if test -z "$CURL_INSTALLED"; then
	echo "${GREEN}Installing curl."
	sudo apt install curl
else 
	echo "${RED}Curl already installed."
fi
echo -e "${RED}--------------CURL---------------\n"

#install zsh
echo -e "${GREEN}--------------ZSH---------------"
if test -z "$ZSH_INSTALLED"; then 
	echo "${GREEN}Installing zsh"
	sudo apt install zsh
else
	echo "${RED}Zsh already installed."
fi
echo -e "${RED}--------------ZSH---------------\n"

#install oh-my-zsh
echo -e "${GREEN}-----------OH-MY-ZSH---------------"
TEMPORAL_DIR=${HOME}/.ohmyzshfiles
mkdir $TEMPORAL_DIR
pushd $TEMPORAL_DIR
curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
(sh install.sh --skip-chsh --unattended) 
popd
rm -rfv $TEMPORAL_DIR
echo -e "${RED}-----------OH-MY-ZSH---------------\n"

#install nerdfonts/hack
echo -e "${GREEN}-----------Nerd-fonts---------------"
sudo apt install fonts-hack-ttf
echo -e "${RED}-----------Nerd-fonts---------------\n"


#install zsh-syntax-highlighting
echo -e "${GREEN}-----------zsh-syntax-highlighting---------------"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
echo -e "${RED}-----------zsh-syntax-highlighting---------------\n"


#install zsh-autosuggestions
echo -e "${GREEN}-----------zsh-autosuggestions---------------"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo -e "${RED}-----------zsh-autosuggestions---------------\n"


#install powerlevel9k
echo -e "${GREEN}-----------powerlevel9k---------------"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
echo -e "${RED}-----------powerlevel9k---------------\n"


#back up previous .zshrc file as .zshrc.backup

FILE=~/.zshrc
if test -e "$FILE"; then
	cp $FILE ${FILE}.backup #backup 
	echo "${GREEN}Previous $FILE saved as ${FILE}.backup..."
fi

echo '
export ZSH="$HOME/.oh-my-zsh"
		
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh dir vcs status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

plugins=(git)

source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

	 ' > $FILE

read -r -p "${RED}SET ZSH AS DEFAULT? [y/N]${RESET}" confirmation
if [ "$confirmation" == y ] || [ "$confirmation" == Y ]; then
	#set zsh as default shell
	sudo chsh -s $(which zsh) $USER
  	echo "${GREEN}ZSH is now the default shell."
else
	echo "${RED}ZSH is not the default shell!"
	echo "${RED} TYPE zsh to use zsh-shell"
fi


echo \
"
Do not forget to set your console font to hack
${GREEN}All done, now restart system to apply settings!
"
 
read -r -p "${RED}RESTART NOW? [y/N]${RESET}" confirmation
if [ "$confirmation" != y ] && [ "$confirmation" != Y ]; then
  echo "${RED}Restart cancelled"
  exit
fi

echo "${GREEN}Hasta la vista baby!"
sudo shutdown -r 0