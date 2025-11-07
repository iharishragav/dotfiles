function fish_greeting
    # Set color for figlet text to a light grey
    echo -ne '\033[38;2;180;180;180m'  # light grey

    figlet sparks -f slant

    # Reset terminal color
    set_color normal

    # Fastfetch without specific color theme (uses default or your prompt colors)

end
