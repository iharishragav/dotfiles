function rollback
    set -l backup_root ~/.config/dotfiles-backups
    
    if not test -d $backup_root
        echo "ERROR: No dotfiles backups found."
        return 1
    end
    
    set -l backups (find $backup_root -mindepth 1 -maxdepth 1 -type d | sort)
    
    if test (count $backups) -eq 0
        echo "ERROR: No dotfiles backups found."
        return 1
    end
    
    set -l backup $backups[-1]
    
    echo "Restoring backup:"
    echo $backup
    
    # Remove current configurations.
    rm -rf ~/.config/hypr
    rm -rf ~/.config/fish
    rm -rf ~/.config/kitty
    rm -rf ~/.config/fastfetch
    rm -rf ~/.config/qutebrowser
    rm -rf ~/.config/quickshell
    rm -rf ~/.config/nvim
    rm -f ~/.config/starship.toml
    
    # Restore backup.
    cp -r $backup/hypr ~/.config/ || return 1
    cp -r $backup/fish ~/.config/ || return 1
    cp -r $backup/kitty ~/.config/ || return 1
    cp -r $backup/fastfetch ~/.config/ || return 1
    cp -r $backup/qutebrowser ~/.config/ || return 1
    cp -r $backup/quickshell ~/.config/ || return 1
    cp -r $backup/nvim ~/.config/ || return 1
    cp $backup/starship.toml ~/.config/ || return 1
    
    echo
    echo "Rollback completed."
    echo "Restored: $backup"
end
