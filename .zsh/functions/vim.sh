mini() {
    if [ ! -r ~/.local/share/nvim/README.md ]; then
        echo "Error: File does not exist or is not readable"
        return 1
    fi

    local_file=$(cat ~/.local/share/nvim/README.md)
    config_file=$(cat ~/.config/nvim/README.md)

    if [[ "$local_file" == *"minimal"* ]]; then # Minimal is in local
        if [[ "$config_file" == *"minimal"* ]]; then # Config is minimal
            nvim;
        elif [[ "$config_file" == *"neovim"* ]]; then # Config is Neovim
            mv ~/.config/nvim ~/.config/neovim
            mv ~/.config/minimal ~/.config/nvim
            nvim;
        fi
        return 0
    elif [[ "$local_file" == *"neovim"* ]]; then # Neovim is in local
        if [[ "$config_file" == *"minimal"* ]]; then # Config is in minimal
            nvim;
        elif [[ "$config_file" == *"neovim"* ]]; then # Both configs are neovim
            mv ~/.config/nvim ~/.config/neovim
            mv ~/.config/minimal ~/.config/nvim
            mv ~/.local/share/nvim ~/.local/share/neovim
            mv ~/.local/share/minimal ~/.local/share/nvim
            nvim;
        fi
        return 0
    else
        echo "File may be unreadable"
        return 1
    fi
}

neovim() {
    if [ ! -r ~/.local/share/nvim/README.md ]; then
        echo "Error: File does not exist or is not readable"
        return 1
    fi

    local_file=$(cat ~/.local/share/nvim/README.md)
    config_file=$(cat ~/.config/nvim/README.md)

    if [[ "$local_file" == *"minimal"* ]]; then # Minimal is in local
        if [[ "$config_file" == *"minimal"* ]]; then # Config is minimal
            mv ~/.config/nvim ~/.config/minimal
            mv ~/.config/neovim ~/.config/nvim
            mv ~/.local/share/nvim ~/.local/share/minimal
            mv ~/.local/share/neovim ~/.local/share/nvim
            nvim;
        elif [[ "$config_file" == *"neovim"* ]]; then # Config is Neovim
            mv ~/.local/share/nvim ~/.local/share/minimal
            mv ~/.local/share/neovim ~/.local/share/nvim
            nvim;
        fi
        return 0
    elif [[ "$local_file" == *"neovim"* ]]; then # Neovim is in local
        if [[ "$config_file" == *"minimal"* ]]; then # Config is in minimal
            mv ~/.config/nvim ~/.config/minimal
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
