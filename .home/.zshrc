# --- Environment & Tools ---
eval "$(fnm env --use-on-cd --shell zsh)"
# eval "$(starship init zsh)" # Uncomment if you use starship later

# --- History Settings ---
HISTFILE=~/.zsh/.zsh-history
HISTSIZE=1000000
SAVEHIST=1000000
setopt autocd
setopt HIST_IGNORE_ALL_DUPS  # Don't save duplicate commands

# --- The Completion System (THE FIX) ---
autoload -Uz compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Make the tab menu navigable with arrow keys
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive completion

# --- Prompt & Visuals ---
export PROMPT="%F{red}%n%f:%F{cyan}%m%f"$'\n'"%F{cyan} %B%30<..<%~%b %F{red}❯❯ "
[ -f ~/.config/scripts/colors/zwaves ] && ~/.config/scripts/colors/zwaves

# --- Keybindings ---
autoload -Uz edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey '^[[C' forward-word       # Ctrl+Right arrow to accept one word of suggestion
bindkey '^f' autosuggest-accept   # Ctrl+f to accept full suggestion

# --- Aliases ---
alias zshrc='nvim ~/.zshrc'
alias zpr='nvim ~/.zprofile'
alias q='exit'
alias c='clear'
alias cat='bat --theme Nord -p'
alias l='eza -lahF --color=always --icons --sort=size --group-directories-first'
alias ls='ls -lahF --color=always'
alias hst='history 1 -1 | cut -c 8- | sort | uniq | fzf | wl-copy'
alias gst='git status'
alias gm='git commit -S'
alias ga='git add .'
alias gp='git push'
alias gpull='git pull'
alias s='nohup sh ~/.config/beansprout/autostart.sh &' 
# --- Functions ---
_startup() {
  echo -ne '\e[5 q' # Beam cursor
  echo ""           # Extra newline for breathing room
}
precmd_functions+=(_startup)

# --- Plugins (MUST BE AT THE END) ---
# 1. Load Autosuggestions first
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# 2. Load Syntax Highlighting LAST
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
