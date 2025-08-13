function fish_greeting
    echo -ne '\x1b[38;5;16m'  # Set colour to primary
    figlet sparks -f slant 
    set_color normal
    fastfetch 
end
