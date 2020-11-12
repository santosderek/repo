#!/usr/bin/zsh

GREEN="\033[1;32m"
NOCOLOR="\033[0m"

echo "\n${GREEN}Getting dotfiles from repo.dyrenex.com:${NOCOLOR}"
curl https://raw.githubusercontent.com/santosderek/repo/master/bin/dotfiledownloader.py | python

echo "${GREEN}done.${NOCOLOR}"
