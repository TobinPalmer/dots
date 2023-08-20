nameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    MSYS_NT*)   machine=Git;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [[ machine == "Mac" ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export ZSHPATH=$HOME/.config/.zsh
export CODE=~/Documents/Code/$1
export EDITOR="nvim"

if [[ machine == "Mac" ]]; then
	export PATH="$HOME/.tmuxifier/bin:$PATH"
	export PATH=$PATH:/Users/tobin/Library/Python/3.9/lib/python/site-packages
	export PATH=$PATH:/Users/tobin/Library/Python/3.9/bin
	export PATH=/usr/local/bin:$PATH
	export HOMEBREW_AUTO_UPDATE_SECS="3600"
	export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
	export BAT_THEME="Dracula"
	export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
	export PATH="/Users/tobin/.opam/default/bin:$PATH"
	export PATH="/Users/tobin/.flutter/bin:$PATH"
	export PATH="/Users/tobin/.cargo/bin:$PATH"
fi

	export VISUAL="$EDITOR"
	echo "Hello, world"
	export ZSHRC_PATH="$HOME/.config/.zsh/.zshrc"
	export PATH="$HOME/.cargo/bin:$PATH"
	export PATH="$HOME/bin:$PATH"

## Jetbrains Toolbox
#export PATH="$PATH:/Users/tobin/Library/Application Support/JetBrains/Toolbox/scripts"
#
#source "$ZSHPATH/configs/nnn.sh"
