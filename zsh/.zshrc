#zshrc
echo "eval \"\$(starship init zsh)\"" >> ${ZSOTDIR:-$HOME}/.zshrc

# Return if not interactive shell
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lah'
alias update='yay -Syu'
alias freeyay='sudo rm -f /var/lib/pacman/db.lck && yay -Sc --noconfirm && rm -rf ~/.cache/yay/* && echo "✅ yay cleaned and lock removed!"'
alias bashrc='nano ~/.bashrc'
alias zshrc='nano ~/.zshrc'
alias tmuxconf='nano ~/.tmux.conf'
alias starshipconf='nano ~/.config/starship.toml'
alias kittyconf='nano ~/.config/kitty/kitty.conf'
alias Gs='git status'
alias c='clear'
alias l='lsd'

# Memory cleanup functions
freemem() {
  echo -e "\nBefore:"
  free -h
  echo 3 | sudo tee /proc/sys/vm/drop_caches >/dev/null
  echo -e "\nAfter:"
  free -h
}
freeswap() {
  echo "Restarting swap..."
  sudo swapoff -a && sudo swapon -a
}

# Git branch in prompt (Zsh style function)
parse_git_branch() {
  local branch=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)
  [[ -n "$branch" ]] && echo " (git: $branch)"
}

# PROMPT: fallback if Starship is not used
if [[ -z "$STARSHIP_SHELL" ]]; then
  PROMPT='%F{cyan}[%n💀%m] %1~$(parse_git_branch)%f %# '
fi

# neofetch on shell start
#command -v neofetch &>/dev/null && neofetch

# PATH exports (clean and organized)
export JAVA_HOME="/usr/local/jdk-21.0.5+11"
export JRE_HOME="$JAVA_HOME"
export PATH="$HOME/.local/bin:$JAVA_HOME/bin:$HOME/go/bin:$PATH"


# plugins (zsh-autosuggestions + zsh-syntax-highlighting)

if [[ -r ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -r ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
eval "$(starship init zsh)"
