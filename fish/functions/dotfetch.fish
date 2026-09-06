function dotfetch
    set -l repo ~/github/dotfiles
    set -l backup_root ~/.config/dotfiles-backups
    set -l timestamp (date "+%Y-%m-%d_%H-%M-%S")
    set -l backup $backup_root/$timestamp
    
    echo "Updating dotfiles repository..."
    
    cd $repo
    
    git pull
    or begin
        echo "ERROR: git pull failed. Nothing was changed."
        cd ~
        return 1
    end
    
    echo
    echo "Creating backup:"
    echo $backup
    
    mkdir -p $backup
    
    # Backup current configuration.
    cp -r ~/.config/hypr $backup/ || return 1
    cp -r ~/.config/fish $backup/ || return 1
    cp -r ~/.config/kitty $backup/ || return 1
    cp -r ~/.config/fastfetch $backup/ || return 1
    cp -r ~/.config/qutebrowser $backup/ || return 1
    cp -r ~/.config/quickshell $backup/ || return 1
    cp -r ~/.config/nvim $backup/ || return 1
    cp ~/.config/starship.toml $backup/ || return 1
    
    echo "Backup created."
    
    echo
    echo "Installing dotfiles..."
    
    # Replace configurations.
    rm -rf ~/.config/hypr
    cp -r $repo/hypr ~/.config/ || return 1
    
    rm -rf ~/.config/fish
    cp -r $repo/fish ~/.config/ || return 1
    
    rm -rf ~/.config/kitty
    cp -r $repo/kitty ~/.config/ || return 1
    
    rm -rf ~/.config/fastfetch
    cp -r $repo/fastfetch ~/.config/ || return 1
    
    rm -rf ~/.config/qutebrowser
    cp -r $repo/qutebrowser ~/.config/ || return 1
    
    rm -rf ~/.config/quickshell
    cp -r $repo/quickshell ~/.config/ || return 1
    
    rm -rf ~/.config/nvim
    cp -r $repo/nvim ~/.config/ || return 1
    
    rm -f ~/.config/starship.toml
    cp $repo/starship.toml ~/.config/ || return 1
    
    echo
    echo "Dotfiles fetched successfully."
    echo "Backup: $backup"
    
    cd ~
end
