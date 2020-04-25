#!/bin/zsh

HOME_DIR=/home/derek

if [ ! -d $HOME_DIR ]; then
    echo "Derek's Homedir not found"
    exit 254
fi 

CONFIG_FILES=(.bashrc .vimrc .zshrc)

cd $HOME_DIR
for FILE in $CONFIG_FILES;
do
    if [ -f $FILE ]; then
        echo "Copying $FILE"
        cp -v $HOME/$FILE $HOME_DIR/.repo/homedir/.config
    fi 
done
