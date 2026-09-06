function dotfetch
    cd ~/github/dotfiles
    
    git pull
    
    cp ~/github/dotfiles/starship.toml ~/.config/
    
    rm -rf ~/.config/hypr
    cp -r ~/github/dotfiles/hypr ~/.config/
    
    rm -rf ~/.config/fish
    cp -r ~/github/dotfiles/fish ~/.config/
    
    rm -rf ~/.config/kitty
    cp -r ~/github/dotfiles/kitty ~/.config/
    
    rm -rf ~/.config/fastfetch
    cp -r ~/github/dotfiles/fastfetch ~/.config/
    
    rm -rf ~/.config/qutebrowser
    cp -r ~/github/dotfiles/qutebrowser ~/.config/
    
    echo "Dotfiles fetched and replaced."
end
