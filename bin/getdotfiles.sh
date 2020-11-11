#!/bin/zsh

GREEN="\033[1;32m"
NOCOLOR="\033[0m"

CONFIG_DIR="~/.config"

echo "\n${GREEN}Getting files from repo...${NOCOLOR}"
curl https://raw.githubusercontent.com/santosderek/repo/master/bin/dotfiledownloader.py | bash


if [ -f $CONFIG_DIR/.zshrc ] && [ $SHELL == "/usr/bin/zsh" ] then
    echo "\n${GREEN}Sourcing zshrc...${NOCOLOR}"
    source $CONFIG_DIR/.zshrc
fi

if [ -f $CONFIG_DIR/.bashrc ] && [ $SHELL == "/bin/bash" ] then
    echo "\n${GREEN}Sourcing bashrc...${NOCOLOR}"
    source $CONFIG_DIR/.bashrc
fi

echo "${GREEN}done.${NOCOLOR}"
