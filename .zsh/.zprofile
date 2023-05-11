eval "$(/opt/homebrew/bin/brew shellenv)"

export ZSHPATH=$HOME/.config/.zsh

export BAT_THEME="Dracula"
export CODE=~/Documents/Code/$1
export EDITOR="nvim"
export PATH="$HOME/.tmuxifier/bin:$PATH"
export PATH=$PATH:/Users/tobin/Library/Python/3.9/lib/python/site-packages
export PATH=$PATH:/Users/tobin/Library/Python/3.9/bin
export PATH=/usr/local/bin:$PATH
export VISUAL="$EDITOR"
export ZSHRC_PATH="~/.config/.zsh/.zshrc"
export HOMEBREW_AUTO_UPDATE_SECS="3600"

# Jetbrains Toolbox
export PATH="$PATH:/Users/tobin/Library/Application Support/JetBrains/Toolbox/scripts"

source "$ZSHPATH/configs/nnn.sh"
