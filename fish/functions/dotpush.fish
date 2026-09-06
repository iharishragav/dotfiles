function dotpush
    set comment "$argv"
    rm -rf ~/github/dotfiles/*
    
    cp ~/.config/starship.toml ~/github/dotfiles/
    cp -r ~/.config/hypr ~/github/dotfiles/
    cp -r ~/.config/fish ~/github/dotfiles/
    cp -r ~/.config/kitty ~/github/dotfiles/
    cp -r ~/.config/fastfetch ~/github/dotfiles/
    cp -r ~/.config/qutebrowser ~/github/dotfiles/
    cp -r ~/.config/quickshell/ ~/github/dotfiles/
    cp -r ~/.config/nvim ~/github/dotfiles/
    cd ~/github/dotfiles
    
    git add -A
    
    echo
    echo "Changes:"
    git status --short
    
    git commit -m "$comment"
    git push
    cd
end
