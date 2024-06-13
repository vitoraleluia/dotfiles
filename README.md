# Dotfiles

## Before install

Packages needed to install the dotfiles:
- git
- stow

```sh
sudo apt install git stow -y
```

## Install

```sh
git clone https://github.com/vitoraleluia/dotfiles.git && cd dotfiles/ && stow . -t ~
```

