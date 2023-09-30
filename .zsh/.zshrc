# Powerline10k configuration
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
fi

source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
# source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
export ZSHPATH=$HOME/.config/.zsh
export PUPPETEER_PRODUCT=firefox npm i puppeteer

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux ;;
    Darwin*)    machine=Mac ;;
    CYGWIN*)    machine=Cygwin ;;
    MINGW*)     machine=MinGw ;;
    MSYS_NT*)   machine=Git ;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [[ "$machine" == "Mac" ]]; then
	source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
fi

if [[ "$machine" == "Linux" ]]; then
  alias nvim="$HOME/bin/nvim.appimage"
fi

if [[ "$machine" == "Linux" ]]; then
  source ~/powerlevel10k/powerlevel10k.zsh-theme
fi

# source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

# Aliases
alias :q="cowsay You\'re not using vim!"
alias :wq="cowsay You\'re not using vim!"
alias bg='batgrep -A=0 -B=0'
alias c="pbcopy"
alias clear='clear && printf "\e[3J"'
alias code="code"
alias exa='exa --icons --all'
alias ls='exa'
alias inject="open -a /Applications/InjectionIII.app/Contents/MacOS/InjectionIII"
# alias fd='cd $(find . -type d -print | fzf)'
alias monkeytype="python3 /Users/tobin/Documents/Code/Python/bots/monkeytype-playwright/main.py"
alias neovide='neovide --multigrid --frame=buttonless'
alias nitrotype="python3 /Users/tobin/Documents/Code/Python/bots/nitrotype-playwright/main.py"
alias notes="python3 /Users/tobin/Documents/Code/Python/school_notes/main.py"
alias emu="/Users/tobin/Library/Android/sdk/emulator/emulator -avd Main_Phone_API_34 -netdelay none -netspeed full"
alias ofzf="nvim \$(fzf)"
alias project="node /Users/tobin/Documents/Code/Web/TS/templates/dist/main.js"
alias brewChromium="brew reinstall --no-quarantine --cask eloston-chromium"
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias reload="source ~/.config/.zsh/.zshrc"
alias resetNPM="rm -rf node_modules package-lock.json && npm i"
alias spacer="defaults write com.apple.dock persistent-apps -array-add '{\"tile-type\"=\"small-spacer-tile\";}'; killall Dock"
alias syncCode="rsync -av --exclude=node_modules --exclude=target ~/Documents/Code/ /Volumes/Code/"
alias trim="ex +'bufdo!%s/\s\+$//e' -scxa"
alias v="pbpaste"
alias zshrc="nvim ~/.config/.zsh/.zshrc"
alias restart="skhd --stop-service;skhd --start-service;yabai --stop-service;yabai --start-service;brew services restart sketchybar"
alias vim="vim -u ~/.config/.vim/init.vim"
alias skim='/Applications/Skim.app/Contents/MacOS/Skim'
alias transferPhotos="rsync -av /Volumes/Untitled/DCIM/100OLYMP /Volumes/Other/Trip"
alias transferGoPro="rsync -av /Volumes/GoPro/DCIM/100GOPRO /Volumes/Other/Trip"
alias convert="python3 ~/Documents/Code/Python/createHTML/main.py;"
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias qemu="qemu-system-x86_64"
alias emulator="/Users/tobin/Library/Android/sdk/emulator/emulator"
alias adb="/Users/tobin/Library/Android/sdk/platform-tools/adb"

function nvims() {
    items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim")
    config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config 󰄾" --height=~50% --layout=reverse --border --exit-0)
    if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
    elif [[ $config == "default" ]]; then
        config=""
    fi
    NVIM_APPNAME=$config nvim $@
}

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# alias flutter="flutter --disable-telemetry"

unset TMUX

# Environment variables
export GPG_TTY=$(tty)

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if [[ "$machine" == "Mac" ]]; then
	eval "$(tmuxifier init -)"
	eval "$(opam env --switch=default)"
	eval "$(flutter bash-completion)"
fi

export CHROME_EXECUTABLE=/Applications/Chromium.app/Contents/MacOS/Chromium

export GPGc_TTY=$(tty)
export NVM_DIR="$HOME/.nvm"

# Oh-My-Zsh configuration
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-wakatime)
source "$ZSH/oh-my-zsh.sh"

# Plugins
if [[ "$machine" == "Mac" ]]; then
	source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
	source $(brew --prefix)/opt/zsh-autocomplete/zsh-autocomplete.plugin.zsh
fi

# Powerline10k prompt configuration
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.config/.zsh/.p10k.zsh.
[[ ! -f ~/.config/.zsh/.p10k.zsh ]] || source ~/.config/.zsh/.p10k.zsh

# Powerline10k configuration
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSHPATH=$HOME/.config/.zsh

# To customize prompt, run `p10k configure` or edit ~/.config/.zsh/.p10k.zsh.
[[ ! -f ~/.config/.zsh/.p10k.zsh ]] || source ~/.config/.zsh/.p10k.zsh

for file in "$ZSHPATH"/functions/*; do
    if [[ -f "$file" ]]; then
        source "$file"
    fi
done

for file in "$ZSHPATH"/configs/*; do
    if [[ -f "$file" ]]; then
        source "$file"
    fi
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
