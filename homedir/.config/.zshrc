# ZSH config

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PROMPT="%F{45}%n%f%F{38}@%f%F{42}%m%f%F{38}:%f%F{7}%~%f> "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.


# Alias
alias ls='ls -l'
alias mv='mv -v'
alias cp='cp -v'
alias editconfig='vim ~/.config/.zshrc'
alias copytorepo='~/.repo/bin/copytorepo.sh'
alias systemlog='sudo tail -f /var/log/syslog'
alias synergy='synergyc --name Wheatley --debug DEBUG --no-tray --enable-crypto --enable-drag-drop 192.168.78.185'

# History
ZHISTORYDIR=$HOME/.cache/zsh
if [ ! -d $ZHISTORYDIR ]; then
    mkdir -p $HOME/$ZHISTORYDIR
fi

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$ZHISTORYDIR/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey -e


# These two lines change tell vim to look into $MYVIMRC location
export VIMINIT='source $MYVIMRC'
export MYVIMRC='~/.config/.vimrc'  

# Must be at the bottom
if [ -d $HOME/.config/zsh-syntax-highlighting ]; then
    source $HOME/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    echo "ZSH-SYNTAX-HIGHLIGHTING not installed! Look into .zshrc for install lines...\n" 
    # mkdir -p $HOME/.config/
    # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.config/zsh-syntax-highlighting
    # source $HOME/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
