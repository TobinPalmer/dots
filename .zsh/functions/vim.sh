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
