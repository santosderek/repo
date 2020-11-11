#!/bin/zsh
# Install script for new Debian based machines
# Script is run and tested in zsh

echo "Updating packages\n"
sudo apt update

echo "Installing packages...\n"
PACKAGES=(htop vim curl git zsh)

for CURPACKAGE in "${PACKAGES[@]}"
do

    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $CURPACKAGE | grep "install ok installed")
    
    if [ "$PKG_OK" != "" ]; then
    	echo "$CURPACKAGE is insalled..."
    else
        echo "Installing $CURPACKAGE!"
        $(apt install $CURPACKAGE)

        # If package fails to install, exit out
        if [ $(echo $?) != 0 ]; then
            echo "\nCould not install. Make sure you have admin privileges!\n"
            exit 254
        fi
    fi

done

echo "\nChecking if user 'derek' exists..."
if [ "$(grep -i ^derek\: /etc/passwd)" = "" ]; then
    echo "Adding user 'derek'"
    /usr/sbin/useradd -m -d /home/derek/ derek
    /usr/sbin/usermod -aG sudo derek
    /usr/bin/passwd derek
else
    echo "Found user 'derek'..."
fi 

# Install configs
echo "Installing dotfiles...\n"
curl -ks https://repo.dyrenex.com/bin/getdotfiles.sh | zsh 


