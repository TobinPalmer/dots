## Powerline10k configuration
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSHPATH=$HOME/.config/.zsh
export PUPPETEER_PRODUCT=firefox npm i puppeteer

# Aliases
alias trim="ex +'bufdo!%s/\s\+$//e' -scxa"
alias zshrc="nvim ~/.config/.zsh/.zshrc"
alias c="pbcopy"
alias v="pbpaste"
alias code="code --profile WebDev"
alias spacer="defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'; killall Dock"
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias resetNPM="rm -rf node_modules package-lock.json && npm i"
alias ofzf="nvim \$(fzf)"
alias :wq="cowsay You\'re not using vim!"
alias :q="cowsay You\'re not using vim!"
alias syncCode="rsync -av --exclude=node_modules Code/ /Volumes/Code/"
alias notes="python3 /Users/tobin/Documents/Code/Python/school_notes/main.py"
alias ntmux="tmux new-session \; split-window -h \; split-window -v \; attach"
alias monkeytype="python3 /Users/tobin/Documents/Code/Python/monkeytype-playwright/main.py"
alias nitrotype="python3 /Users/tobin/Documents/Code/Python/nitrotype-playwright/main.py"
alias fd='cd $(find . -type d \( -name "node_modules" -o -name "venv" -o -name "__pycache__" -o -name ".git" \) -prune -false -o -print | fzf)'
alias neovide='neovide --multigrid --frame=buttonless --maximized'
alias exa='exa --icons'
alias clear='clear && printf "\e[3J"'


unset TMUX

# Environment variables
export GPG_TTY=$(tty)

export GPGc_TTY=$(tty)
export NVM_DIR="$HOME/.nvm"

# Oh-My-Zsh configuration
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
source "$ZSH/oh-my-zsh.sh"

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
