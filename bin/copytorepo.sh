#!/bin/zsh

CONFIG_FILES=(.bashrc .vimrc .config/.zshrc)

if [ ! -d $HOME ]; then
    echo "$HOME not found"
    exit 254
fi 


cd $HOME
for FILE in $CONFIG_FILES;
do
    if [ -f $FILE ]; then
        echo "Copying $FILE"
        cp -v $HOME/$FILE $HOME/.repo/homedir/.config
    fi 
done
