function dotfetch
    cd ~/github/dotfiles
    
    git pull
    
    mv ~/.config/starship.toml ~/.config/starship.toml.bak
    cp ~/github/dotfiles/starship.toml ~/.config/
    
    mv ~/.config/hypr ~/.config/hypr-bak
    cp -r ~/github/dotfiles/hypr ~/.config/
    
    mv ~/.config/fish ~/.config/fish-bak
    cp -r ~/github/dotfiles/fish ~/.config/
    
    mv ~/.config/kitty ~/.config/kitty-bak
    cp -r ~/github/dotfiles/kitty ~/.config/
    
    mv ~/.config/fastfetch ~/.config/fastfetch-bak
    cp -r ~/github/dotfiles/fastfetch ~/.config/
    
    mv ~/.config/quickshell/ ~/.config/quickshell-bak
    cp -r ~/github/dotfiles/quickshell/ ~/.config/quickshell/
    
    mv ~/.config/qutebrowser/ ~/.config/qutebrowser-bak
    cp -r ~/github/dotfiles/qutebrowser ~/.config/
    
    echo "Dotfiles fetched and replaced."
    cd
end
