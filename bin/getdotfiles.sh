#!/bin/zsh

GREEN="\033[1;32m"
NOCOLOR="\033[0m"

CONFIG_REPO_URL=https://api.github.com/repos/santosderek/repo/contents/homedir/.config
CONFIG_DIR=$HOME/.config

if [ ! -d $CONFIG_DIR ]; then
    mkdir -p $CONFIG_DIR 
fi

if [ $(dpkg-query -W --showformat='${Status}\n' python2 | grep "install ok installed") != "" ]; then
    apt install python2
fi

echo "${GREEN}Getting repo contents...${NOCOLOR}"
JSON=$(curl -k "$CONFIG_REPO_URL")
COUNT=$(echo $JSON | python2 -c 'import sys,json;data=json.loads(sys.stdin.read()); print len(data)')

echo "\n${GREEN}Getting files from repo...${NOCOLOR}"
for ((POS=0; POS < $COUNT ; POS++))
do
    NAME=$(echo $JSON | python2 -c "import sys,json;data=json.loads(sys.stdin.read()); print data[$POS]['name']")
    URL=$(echo $JSON | python2 -c "import sys,json;data=json.loads(sys.stdin.read()); print data[$POS]['download_url']")
    
    echo "\nDownloading $NAME from $URL to $CONFIG_DIR/$NAME"
    
    $(curl -k $URL > $CONFIG_DIR/$NAME)
done

echo "\n${GREEN}Moving .zshenv to $HOME... ${NOCOLOR}"
mv -v $CONFIG_DIR/.zshenv $HOME

if [ -f $CONFIG_DIR/.zshrc ]; then
    echo "\n${GREEN}Sourcing...${NOCOLOR}"
    source $CONFIG_DIR/.zshrc
fi

echo "${GREEN}done.${NOCOLOR}"
