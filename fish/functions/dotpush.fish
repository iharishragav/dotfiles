function dotpush
    set -l repo ~/github/dotfiles
    
    if test (count $argv) -eq 0
        echo "Usage: dotpush <commit message>"
        return 1
    end
    
    echo "Syncing ~/.config → dotfiles..."
    
    mkdir -p $repo
    
    # Remove only the managed dotfiles from the repository.
    rm -rf \
                $repo/hypr \
                $repo/fish \
                $repo/kitty \
                $repo/fastfetch \
                $repo/qutebrowser \
                $repo/quickshell \
                $repo/nvim
    
    rm -f $repo/starship.toml
    
    # Copy current configurations.
    cp -r ~/.config/hypr $repo/ || return 1
    cp -r ~/.config/fish $repo/ || return 1
    cp -r ~/.config/kitty $repo/ || return 1
    cp -r ~/.config/fastfetch $repo/ || return 1
    cp -r ~/.config/qutebrowser $repo/ || return 1
    cp -r ~/.config/quickshell $repo/ || return 1
    cp -r ~/.config/nvim $repo/ || return 1
    cp ~/.config/starship.toml $repo/ || return 1
    
    cd $repo
    
    echo
    echo "Changes:"
    git status --short
    
    git add -A
    
    if git diff --cached --quiet
        echo
        echo "No changes to commit."
        cd ~
        return 0
    end
    
    git commit -m "$argv"
    or begin
        cd ~
        return 1
    end
    
    git push
    or begin
        cd ~
        return 1
    end
    
    echo
    echo "Dotfiles pushed successfully."
    
    cd ~
end
