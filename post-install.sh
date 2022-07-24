#!/usr/bin/env bash

# How to use: `$ ./post-install.sh`

## programs
PROGRAMS_TO_INSTALL=(
  snapd
  curl
  wget
  git
  htop
  bat
  neofetch
  exa
  vim
  default-jdk
  virtualbox
  timeshift
  vlc
  qbittorrent
  thunderbird
  zsh
  okular
  ubuntu-restricted-extras
)

## Snaps
SNAPS_TO_INSTALL=(
  code
  discord
  insomnia
  brave
  marktext
)

##FOLDERS
DOWNLOAD_FOLDER="$HOME/Downloads/install_temp"

#COLORS
RED='\e[1;91m'
GREEN='\e[1;92m'
NO_COLOR='\e[0m'

#FUNCTIONS

## System update
apt_update(){
  sudo apt update && sudo apt dist-upgrade -y
}

## Internet conection test
connection_test(){
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${RED}[ERROR] - No internet connection! ${NO_COLOR}"
  exit 1
else
  echo -e "${GREEN}[INFO] - Internet connection established.${NO_COLOR}"
fi
}


## Remove APT locks
unlock_apt(){
  sudo rm /var/lib/dpkg/lock-frontend
  sudo rm /var/cache/apt/archives/lock
}

## Update repos
just_apt_update(){
sudo apt update -y
}

## Download .debs

install_programs(){

echo -e "${GREEN}[INFO] - Installing packages from repos${NO_COLOR}"

for program in ${PROGRAMS_TO_INSTALL[@]}; do
  sudo apt install "$program" -y
done

## Install .deb packages
echo -e "${GREEN}[INFO] - Installing Snap packages${NO_COLOR}"

for snap in ${SNAPS_TO_INSTALL[@]}; do
  sudo snap install "$snap" -y
done
}

## Last touches and cleanup

system_clean(){
apt_update -y
flatpak update -y
sudo apt autoclean -y
sudo apt autoremove -y
}

# Running all the functions
unlock_apt
connection_test
unlock_apt
apt_update
unlock_apt
just_apt_update
install_programs
apt_update
system_clean

## Ending message

  echo -e "${GREEN}[INFO] - All done! :)${NO_COLOR}"
