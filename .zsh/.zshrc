## Powerline10k configuration
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSHPATH=$HOME/.config/.zsh

# Aliases
alias trim="ex +'bufdo!%s/\s\+$//e' -scxa"
alias zshrc="nvim ~/.config/.zsh/.zshrc"
alias c="pbcopy"
alias v="pbpaste"
alias code="code --profile WebDev"
alias spacer="defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'; killall Dock"
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias resetNPM="rm -rf node_modules package-lock.json && npm i"
alias resetNPM="cp -r"
alias ofzf="nvim \$(fzf)"
alias :wq="cowsay You\'re not using vim!"
alias :q="cowsay You\'re not using vim!"

alias monkeytype="python3 /Users/tobin/Documents/Code/Python/monkeytype-playwright/main.py"
alias nitrotype="python3 /Users/tobin/Documents/Code/Python/nitrotype-playwright/main.py"

swiftUI() {
    xcodebuild
    open build/Release/$1.app/
}


# Functions
clearSwaps() {
    rm -rf ~/.local/share/nvim/swap/*
}

batchRename() {
    \ls | nvim "+%s/.*/\=\"mv -i \".submatch(0).\" \".substitute(submatch(0), \"\", \"\", \"g\")/g"
}

generate_mac_address () {
    sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport en0 -z
    ADDRESS=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
    echo "Changing Mac Address to $ADDRESS"
    sudo ifconfig en0 ether $ADDRESS
}

testing() {
    local config_name="$1"

    if [ -z "$config_name" ]; then
        echo "Error: Configuration name is not specified"
        return 1
    fi

    if [ ! -r "$HOME/.local/share/nvim/readme.md" ]; then
        echo "Error: File does not exist or is not readable"
        return 1
    fi

    local_file=$(cat "$HOME/.local/share/nvim/readme.md")
    config_file=$(cat "$HOME/.config/nvim/readme.md")

    if [[ "$local_file" == *"$config_name"* ]]; then # Configuration is in local
        if [[ "$config_file" == *"$config_name"* ]]; then # Config is in specified configuration
            nvim;
        else # Config is not in specified configuration
            mv "$HOME/.config/nvim" "$HOME/.config/backup-nvim"
            mv "$HOME/.config/$config_name" "$HOME/.config/nvim"
            nvim;
        fi
        return 0
    elif [[ "$config_file" == *"$config_name"* ]]; then # Configuration is in config
        mv "$HOME/.config/nvim" "$HOME/.config/backup-nvim"
        mv "$HOME/.config/$config_name" "$HOME/.config/nvim"
        mv "$HOME/.local/share/nvim" "$HOME/.local/share/backup-nvim"
        mv "$HOME/.local/share/$config_name" "$HOME/.local/share/nvim"
        nvim;
        return 0
    else
        echo "Error: Configuration $config_name not found"
        return 1
    fi
}


avim() {
    if [ ! -r ~/.local/share/nvim/readme.md ]; then
        echo "Error: File does not exist or is not readable"
        return 1
    fi

    local_file=$(cat ~/.local/share/nvim/readme.md)
    config_file=$(cat ~/.config/nvim/readme.md)

    if [[ "$local_file" == *"astrovim"* ]]; then # Astrovim is in local
        if [[ "$config_file" == *"astrovim"* ]]; then # Config is astrovim
            nvim;
        elif [[ "$config_file" == *"neovim"* ]]; then # Config is Neovim
            mv ~/.config/nvim ~/.config/neovim
            mv ~/.config/avim ~/.config/nvim
            nvim;
        fi
        return 0
    elif [[ "$local_file" == *"neovim"* ]]; then # Neovim is in local
        if [[ "$config_file" == *"astrovim"* ]]; then # Config is in astrovim
            nvim;
        elif [[ "$config_file" == *"neovim"* ]]; then # Both configs are neovim
            mv ~/.config/nvim ~/.config/neovim
            mv ~/.config/avim ~/.config/nvim
            mv ~/.local/share/nvim ~/.local/share/neovim
            mv ~/.local/share/avim ~/.local/share/nvim
            nvim;
        fi
        return 0
    else
        echo "File may be unreadable"
        return 1
    fi
}

neovim() {
    if [ ! -r ~/.local/share/nvim/readme.md ]; then
        echo "Error: File does not exist or is not readable"
        return 1
    fi

    local_file=$(cat ~/.local/share/nvim/readme.md)
    config_file=$(cat ~/.config/nvim/readme.md)

    if [[ "$local_file" == *"astrovim"* ]]; then # Astrovim is in local
        if [[ "$config_file" == *"astrovim"* ]]; then # Config is astrovim
            mv ~/.config/nvim ~/.config/avim
            mv ~/.config/neovim ~/.config/nvim
            mv ~/.local/share/nvim ~/.local/share/avim
            mv ~/.local/share/neovim ~/.local/share/nvim
            nvim;
        elif [[ "$config_file" == *"neovim"* ]]; then # Config is Neovim
            mv ~/.local/share/nvim ~/.local/share/avim
            mv ~/.local/share/neovim ~/.local/share/nvim
            nvim;
        fi
        return 0
    elif [[ "$local_file" == *"neovim"* ]]; then # Neovim is in local
        if [[ "$config_file" == *"astrovim"* ]]; then # Config is in astrovim
            mv ~/.config/nvim ~/.config/avim
            mv ~/.config/neovim ~/.config/nvim
            nvim;
        elif [[ "$config_file" == *"neovim"* ]]; then # Both configs are neovim
            nvim;
        fi
        return 0
    else
        echo "File may be unreadable"
        return 1
    fi
}

lvim () {
    # -n == Open in neovide
    if [ "$1" = "-n" ]; then
        if [ "$2" != "" ]; then
            if [ "$2" = "." ]; then
                bash ~/.config/.zsh/scripts/open-neovide.sh "$(pwd)"
            else
                bash ~/.config/.zsh/scripts/open-neovide.sh "$2"
            fi
        else
            bash ~/.config/.zsh/scripts/open-neovide.sh
        fi
        return 1
    fi

    if [ $# -eq 0 ]; then
        ~/.local/bin/lvim
    elif [ "$1" = "." ]; then
        ~/.local/bin/lvim "$(pwd)"
    else
        ~/.local/bin/lvim "$1"
    fi
}

# Sketchybar interactivity overloads
function brew() {
    command brew "$@"

    if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
        sketchybar --trigger brew_update
    fi
}

lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}

tere() {
    local result=$(command tere "$@")
    [ -n "$result" ] && cd -- "$result"
}

ask() { python3 /Users/tobin/Documents/Code/Python/chatgpt-wrapper/main.py "$1" }
TA() { find "$1" -type d -exec SetFile -d "`date +%m/%d/%Y\ %H:%M:%S`" {} + }
currGrep() { grep -r --exclude-dir='node_modules' --exclude-dir='.git' --exclude-dir='dist'  "$1" . }
term() { open -a Terminal "$1" }
warp() { open -a "warp" "$1" }
FC() { cd ~/Documents/Code/"$1" }

# Environment variables
export GPG_TTY=$(tty)

export GPGc_TTY=$(tty)
export NVM_DIR="$HOME/.nvm"

# Oh-My-Zsh configuration
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
source "$ZSH/oh-my-zsh.sh"
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $(brew --prefix)/opt/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# NVM configuration
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Powerline10k prompt configuration
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.config/.zsh/.p10k.zsh.
[[ ! -f ~/.config/.zsh/.p10k.zsh ]] || source ~/.config/.zsh/.p10k.zsh

source "$ZSHPATH/functions/n.sh"
# Powerline10k configuration
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSHPATH=$HOME/.config/.zsh

# Aliases
alias trim="ex +'bufdo!%s/\s\+$//e' -scxa"
alias zshrc="nvim ~/.config/.zsh/.zshrc"
alias c="pbcopy"
alias v="pbpaste"
alias code="code --profile WebDev"
alias spacer="defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'; killall Dock"
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias resetNPM="rm -rf node_modules package-lock.json && npm i"
alias resetNPM="cp -r"
alias :wq="cowsay You\'re not using vim!"
alias :q="cowsay You\'re not using vim!"

alias monkeytype="python3 /Users/tobin/Documents/Code/Python/monkeytype-playwright/main.py"
alias nitrotype="python3 /Users/tobin/Documents/Code/Python/nitrotype-playwright/main.py"

swiftUI() {
    xcodebuild
    open build/Release/$1.app/
}


# Functions
clearSwaps() {
    rm -rf ~/.local/share/nvim/swap/*
}

batchRename() {
    \ls | nvim "+%s/.*/\=\"mv -i \".submatch(0).\" \".substitute(submatch(0), \"\", \"\", \"g\")/g"
}

generate_mac_address () {
    sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport en0 -z
    ADDRESS=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
    echo "Changing Mac Address to $ADDRESS"
    sudo ifconfig en0 ether $ADDRESS
}

testing() {
    local config_name="$1"

    if [ -z "$config_name" ]; then
        echo "Error: Configuration name is not specified"
        return 1
    fi

    if [ ! -r "$HOME/.local/share/nvim/readme.md" ]; then
        echo "Error: File does not exist or is not readable"
        return 1
    fi

    local_file=$(cat "$HOME/.local/share/nvim/readme.md")
    config_file=$(cat "$HOME/.config/nvim/readme.md")

    if [[ "$local_file" == *"$config_name"* ]]; then # Configuration is in local
        if [[ "$config_file" == *"$config_name"* ]]; then # Config is in specified configuration
            nvim;
        else # Config is not in specified configuration
            mv "$HOME/.config/nvim" "$HOME/.config/backup-nvim"
            mv "$HOME/.config/$config_name" "$HOME/.config/nvim"
            nvim;
        fi
        return 0
    elif [[ "$config_file" == *"$config_name"* ]]; then # Configuration is in config
        mv "$HOME/.config/nvim" "$HOME/.config/backup-nvim"
        mv "$HOME/.config/$config_name" "$HOME/.config/nvim"
        mv "$HOME/.local/share/nvim" "$HOME/.local/share/backup-nvim"
        mv "$HOME/.local/share/$config_name" "$HOME/.local/share/nvim"
        nvim;
        return 0
    else
        echo "Error: Configuration $config_name not found"
        return 1
    fi
}


avim() {
    if [ ! -r ~/.local/share/nvim/readme.md ]; then
        echo "Error: File does not exist or is not readable"
        return 1
    fi

    local_file=$(cat ~/.local/share/nvim/readme.md)
    config_file=$(cat ~/.config/nvim/readme.md)

    if [[ "$local_file" == *"astrovim"* ]]; then # Astrovim is in local
        if [[ "$config_file" == *"astrovim"* ]]; then # Config is astrovim
            nvim;
        elif [[ "$config_file" == *"neovim"* ]]; then # Config is Neovim
            mv ~/.config/nvim ~/.config/neovim
            mv ~/.config/avim ~/.config/nvim
            nvim;
        fi
        return 0
    elif [[ "$local_file" == *"neovim"* ]]; then # Neovim is in local
        if [[ "$config_file" == *"astrovim"* ]]; then # Config is in astrovim
            nvim;
        elif [[ "$config_file" == *"neovim"* ]]; then # Both configs are neovim
            mv ~/.config/nvim ~/.config/neovim
            mv ~/.config/avim ~/.config/nvim
            mv ~/.local/share/nvim ~/.local/share/neovim
            mv ~/.local/share/avim ~/.local/share/nvim
            nvim;
        fi
        return 0
    else
        echo "File may be unreadable"
        return 1
    fi
}

neovim() {
    if [ ! -r ~/.local/share/nvim/readme.md ]; then
        echo "Error: File does not exist or is not readable"
        return 1
    fi

    local_file=$(cat ~/.local/share/nvim/readme.md)
    config_file=$(cat ~/.config/nvim/readme.md)

    if [[ "$local_file" == *"astrovim"* ]]; then # Astrovim is in local
        if [[ "$config_file" == *"astrovim"* ]]; then # Config is astrovim
            mv ~/.config/nvim ~/.config/avim
            mv ~/.config/neovim ~/.config/nvim
            mv ~/.local/share/nvim ~/.local/share/avim
            mv ~/.local/share/neovim ~/.local/share/nvim
            nvim;
        elif [[ "$config_file" == *"neovim"* ]]; then # Config is Neovim
            mv ~/.local/share/nvim ~/.local/share/avim
            mv ~/.local/share/neovim ~/.local/share/nvim
            nvim;
        fi
        return 0
    elif [[ "$local_file" == *"neovim"* ]]; then # Neovim is in local
        if [[ "$config_file" == *"astrovim"* ]]; then # Config is in astrovim
            mv ~/.config/nvim ~/.config/avim
            mv ~/.config/neovim ~/.config/nvim
            nvim;
        elif [[ "$config_file" == *"neovim"* ]]; then # Both configs are neovim
            nvim;
        fi
        return 0
    else
        echo "File may be unreadable"
        return 1
    fi
}

lvim () {
    # -n == Open in neovide
    if [ "$1" = "-n" ]; then
        if [ "$2" != "" ]; then
            if [ "$2" = "." ]; then
                bash ~/.config/.zsh/scripts/open-neovide.sh "$(pwd)"
            else
                bash ~/.config/.zsh/scripts/open-neovide.sh "$2"
            fi
        else
            bash ~/.config/.zsh/scripts/open-neovide.sh
        fi
        return 1
    fi

    if [ $# -eq 0 ]; then
        ~/.local/bin/lvim
    elif [ "$1" = "." ]; then
        ~/.local/bin/lvim "$(pwd)"
    else
        ~/.local/bin/lvim "$1"
    fi
}

# Sketchybar interactivity overloads
function brew() {
    command brew "$@"

    if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
        sketchybar --trigger brew_update
    fi
}


tere() {
    local result=$(command tere "$@")
    [ -n "$result" ] && cd -- "$result"
}

ask() { python3 /Users/tobin/Documents/Code/Python/chatgpt-wrapper/main.py "$1" }
TA() { find "$1" -type d -exec SetFile -d "`date +%m/%d/%Y\ %H:%M:%S`" {} + }
currGrep() { grep -r --exclude-dir='node_modules' --exclude-dir='.git' --exclude-dir='dist'  "$1" . }
term() { open -a Terminal "$1" }
warp() { open -a "warp" "$1" }
FC() { cd ~/Documents/Code/"$1" }

# Environment variables
export GPG_TTY=$(tty)

export GPGc_TTY=$(tty)
export NVM_DIR="$HOME/.nvm"

# Oh-My-Zsh configuration
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
source "$ZSH/oh-my-zsh.sh"
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $(brew --prefix)/opt/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# NVM configuration
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Powerline10k prompt configuration
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.config/.zsh/.p10k.zsh.
[[ ! -f ~/.config/.zsh/.p10k.zsh ]] || source ~/.config/.zsh/.p10k.zsh

source "$ZSHPATH/functions/lazygit.sh"
# source "$ZSHPATH/functions/n.sh"
