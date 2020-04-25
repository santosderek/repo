#!/bin/zsh

GREEN="\033[1;32m"
NOCOLOR="\033[0m"

CONFIG_REPO_URL=https://api.github.com/repos/santosderek/repo/contents/homedir/.config
CONFIG_DIR=/home/derek/.config

if [ ! -d $CONFIG_DIR ]; then
    mkdir -p $CONFIG_DIR 
fi

echo "${GREEN}Getting repo contents...${NOCOLOR}"
JSON=$(curl -k "$CONFIG_REPO_URL")

COUNT=$(echo $JSON | python -c 'import sys,json;data=json.loads(sys.stdin.read()); print len(data)')

echo "\n${GREEN}Getting files from repo...${NOCOLOR}"
for ((POS=0; POS < $COUNT ; POS++))
do
    NAME=$(echo $JSON | python -c "import sys,json;data=json.loads(sys.stdin.read()); print data[$POS]['name']")
    URL=$(echo $JSON | python -c "import sys,json;data=json.loads(sys.stdin.read()); print data[$POS]['download_url']")
    
    echo "\nDownloading $NAME from $URL to $CONFIG_DIR/$NAME"
    
    $(curl -k $URL > $CONFIG_DIR/$NAME)
done

echo "\n{GREEN}Moving .zshenv to $HOME... ${NOCOLOR}"
mv $CONFIG_DIR/.zshenv $HOME