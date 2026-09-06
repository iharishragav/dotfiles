function rollback
    rm -rf ~/.config/quickshell/
    cp -r ~/.config/quickshell-bak ~/.config/quickshell/
    rm -rf ~/.config/fastfetch/
    cp -r ~/.config/fastfetch-bak ~/.config/fastfetch/
    rm -rf ~/.config/kitty/
    cp -r ~/.config/kitty-bak ~/.config/kitty/
    rm -rf ~/.config/starship.toml 
    cp ~/.config/starship.toml.bak ~/.config/starship.toml 
    rm -rf .config/qutebrowser/
    cp ~/.config/qutebrowser-bak ~/.config/qutebrowser/
    rm -rf ~/.config/fish
    cp ~/.config/fish-bak ~/.config/fish
    echo "back--up completed "
end
