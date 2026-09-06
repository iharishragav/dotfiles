function dotfetch
    cd ~/github/dotfiles
    
    git pull
    rm -rf ~/.config/starship.toml.bak
    mv ~/.config/starship.toml ~/.config/starship.toml.bak
    cp ~/github/dotfiles/starship.toml ~/.config/
    
    rm -rf ~/.config/hypr-bak
    mv ~/.config/hypr ~/.config/hypr-bak
    cp -r ~/github/dotfiles/hypr ~/.config/
    rm -rf ~/.config/fish-bak/
    mv ~/.config/fish ~/.config/fish-bak
    cp -r ~/github/dotfiles/fish ~/.config/
    rm -rf ~/.config/kitty-bak/
    mv ~/.config/kitty ~/.config/kitty-bak
    cp -r ~/github/dotfiles/kitty ~/.config/
    rm -rf ~/.config/fastfetch-bak/
    mv ~/.config/fastfetch ~/.config/fastfetch-bak
    cp -r ~/github/dotfiles/fastfetch ~/.config/
    rm -rf ~/.config/quickshell-bak/
    mv ~/.config/quickshell/ ~/.config/quickshell-bak
    cp -r ~/github/dotfiles/quickshell/ ~/.config/quickshell/
    rm -rf ~/.config/qutebrowser-bak/
    mv ~/.config/qutebrowser/ ~/.config/qutebrowser-bak
    cp -r ~/github/dotfiles/qutebrowser ~/.config/
    rm -rf ~/.config/nvim-bak/
    mv ~/.config/nvim ~/.config/nvim-bak
    echo "Dotfiles fetched and replaced."
    cd
end
