## Powerline10k configuration
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
fi
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
# source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
export ZSHPATH=$HOME/.config/.zsh
export PUPPETEER_PRODUCT=firefox npm i puppeteer

# Aliases
alias :q="cowsay You\'re not using vim!"
alias :wq="cowsay You\'re not using vim!"
alias bg='batgrep -A=0 -B=0'
alias c="pbcopy"
alias clear='clear && printf "\e[3J"'
alias code="code"
alias exa='exa --icons --all'
alias fd='cd $(find . -type d -print | fzf)'
alias monkeytype="python3 /Users/tobin/Documents/Code/Python/monkeytype-playwright/main.py"
alias neovide='neovide --multigrid --frame=buttonless'
alias nitrotype="python3 /Users/tobin/Documents/Code/Python/bots/nitrotype-playwright/main.py"
alias notes="python3 /Users/tobin/Documents/Code/Python/school_notes/main.py"
alias ofzf="nvim \$(fzf)"
alias project="node /Users/tobin/Documents/Code/Web/TS/templates/dist/main.js"
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
alias convert="python3 ~/Documents/Code/Python/createHTML/main.py;"

alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

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



# alias flutter="flutter --disable-telemetry"

unset TMUX

# Environment variables
export GPG_TTY=$(tty)

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

eval "$(tmuxifier init -)"
eval "$(opam env --switch=default)"
eval "$(flutter bash-completion)"

export CHROME_EXECUTABLE=/Applications/Chromium.app/Contents/MacOS/Chromium

export GPGc_TTY=$(tty)
export NVM_DIR="$HOME/.nvm"

# Oh-My-Zsh configuration
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
# source "$ZSH/oh-my-zsh.sh"

# Plugins
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $(brew --prefix)/opt/zsh-autocomplete/zsh-autocomplete.plugin.zsh

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
