# ─── Starship Prompt ───
if [[ -z "$STARSHIP_SOURCED" ]]; then
  eval "$(starship init zsh)"
  export STARSHIP_SOURCED=1
fi

# ─── Return if not interactive ───
[[ $- != *i* ]] && return

# ─── Aliases ───
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

# ─── Memory Cleanup ───
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

# ─── PATH Exports ───
export JAVA_HOME="/usr/local/jdk-21.0.5+11"
export JRE_HOME="$JAVA_HOME"
export PATH="$HOME/.local/bin:$JAVA_HOME/bin:$HOME/go/bin:$PATH"

# ─── ZSH Plugins ───
if [[ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [[ -f "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && ! typeset -f _zsh_highlight &>/dev/null; then
  source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
