eval "$(/opt/homebrew/bin/brew shellenv)"

export ZSHPATH=$HOME/.config/.zsh

export PATH=$PATH:/Users/tobin/Library/Python/3.9/lib/python/site-packages
export EDITOR="nvim"
export VISUAL="$EDITOR"
export PATH=/usr/local/bin:$PATH
export ZSHRC_PATH="~/.config/.zsh/.zshrc"
export CODE=~/Documents/Code/$1

# Jetbrains Toolbox
export PATH="$PATH:/Users/tobin/Library/Application Support/JetBrains/Toolbox/scripts"

source "$ZSHPATH/configs/nnn.sh"
