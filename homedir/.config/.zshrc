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

# History
ZHISTORYDIR=$HOME/.cache/zsh
if [ -f $ZHISTORYDIR ]; then
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
