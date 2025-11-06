function fish_greeting
    # Set color for figlet text
    echo -ne '\033[38;2;155;183;227m'  # light blue
    figlet sparks -f slant

    # Reset terminal color
    set_color normal

    # Fastfetch with light pink theme
    fastfetch 
end
