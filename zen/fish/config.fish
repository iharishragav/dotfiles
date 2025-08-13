if status is-interactive
    # Starship custom prompt
    starship init fish | source

    # Custom colours
    cat ~/.local/state/caelestia/sequences.txt 2> /dev/null

    # For jumping between prompts in foot terminal
    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end
end
# ─── Aliases ───
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ll='lsd -lah'
alias update='yay -Syu'
alias freeyay='sudo rm -f /var/lib/pacman/db.lck; and yay -Sc --noconfirm; and rm -rf ~/.cache/yay/*; and echo "✅ yay cleaned and lock removed!"'
alias bashrc='nano ~/.bashrc'
alias zshrc='nano ~/.zshrc'
alias tmuxconf='nano ~/.tmux.conf'
alias starshipconf='nano ~/.config/starship.toml'
alias fishconf='nano ~/.config/fish/config.fish'
alias meenconf='nano ~/.config/fish/config.fish'
alias hyprconf='nano .config/hypr/hyprland.conf'
alias Gs='git status'
alias c='clear'
alias l='lsd'
alias fluxion='cd fluxion && sudo ./fluxion.sh && cd'
alias IP='ip -c -br a'

# ─── Memory Functions ───
function freemem
  echo -e "\nBefore:"
  free -h
  echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
  echo -e "\nAfter:"
  free -h
end

function freeswap
  echo "Restarting swap..."
  sudo swapoff -a; and sudo swapon -a
end

function savecmd
    set last_cmd (history | head -n 1)

    # Remove leading sudo
    if test (string match -r "^sudo " $last_cmd)
        set last_cmd (string replace -r "^sudo " "" $last_cmd)
    end

    set VAULT "$HOME/ObsidianVault/Commands"

    # Get first word of the command
    set cmd_name (echo $last_cmd | awk '{print $1}')

    # Map commands to notes
    switch $cmd_name
        case ls cd pwd mkdir rm cp mv
            set note "Linux Basics"
        case nano vim nvim code
            set note "Editor Commands"
        case git
            set note "Git Commands"
        case docker
            set note "Docker Commands"
        case ping curl wget ifconfig ip nmap
            set note "Networking Commands"
        case '*'
            set note (string upper (string sub -l 1 $cmd_name))(string sub -s 2 $cmd_name)" Commands"
    end

    set NOTE_PATH "$VAULT/$note.md"

    # Create the note if it doesn't exist
    if test ! -f "$NOTE_PATH"
        echo "# $note" > "$NOTE_PATH"
        echo "---" >> "$NOTE_PATH"
        echo "📅 Created on "(date "+%Y-%m-%d %H:%M:%S") >> "$NOTE_PATH"
        echo "---" >> "$NOTE_PATH"
    end

    # Append the command
    echo -e "\n```bash\n$last_cmd\n```" >> "$NOTE_PATH"
    echo "✅ Added '$last_cmd' to $NOTE_PATH"
end



# ─── PATH Exports ───
set -Ux JAVA_HOME "/usr/local/jdk-21.0.5+11"
set -Ux JRE_HOME "$JAVA_HOME"
set -U fish_user_paths $HOME/.local/bin $JAVA_HOME/bin $HOME/go/bin $fish_user_paths

set -Ux PATH "$HOME/.local/bin:$PATH"
