function rollback
    rm -rf ~/.config/quickshell/
    mv ~/.config/quickshell-bak ~/.config/quickshell/
    rm -rf ~/.config/fastfetch/
    mv  ~/.config/fastfetch-bak ~/.config/fastfetch/
    rm -rf ~/.config/kitty/
    mv ~/.config/kitty-bak ~/.config/kitty/
    rm -rf ~/.config/starship.toml
    mv ~/.config/starship.toml.bak ~/.config/starship.toml
    rm -rf .config/qutebrowser/
    mv ~/.config/qutebrowser-bak ~/.config/qutebrowser/
    rm -rf ~/.config/fish
    mv ~/.config/fish-bak ~/.config/fish
    rm -rf ~/.config/nvim/
    mv ~/.config/nvim-bak ~/.config/nvim/
    echo "back--up completed "
end
