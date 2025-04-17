
# ──────────────────────────────────────────────────────────────────────────────
# 1) Preferred shell options
# ──────────────────────────────────────────────────────────────────────────────
setopt autocd               # cd by just typing directory name
setopt correct              # spell‑correct commands
setopt no_beep              # no bell
setopt NO_CASE_GLOB         # make globs case‑insensitive
# Make completion matching case‑insensitive too
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Save History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# ──────────────────────────────────────────────────────────────────────────────
# fzf key bindings for interactive history and file search
source <(fzf --zsh)

# Enable fzf's history search and preview
export FZF_CTRL_R_OPTS="--preview 'echo {}'"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"

# Adjust height of fzf window for better UI
export FZF_HEIGHT=40%

# ──────────────────────────────────────────────────────────────────────────────
# 2) Aliases & PATH tweaks
# ──────────────────────────────────────────────────────────────────────────────
alias ls='eza --icons=always'
alias ll='eza -alh --icons=always'
alias lg='lazygit'
alias vim='nvim'
alias ld='lazydocker'
export PATH="$HOME/.local/bin:$PATH"

# ──────────────────────────────────────────────────────────────────────────────
# 3) Zinit installer chunk (leave as-is)
# ──────────────────────────────────────────────────────────────────────────────
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33}%F{220}Installing ZDHARMA-CONTINUUM Initiative Plugin Manager..."
  mkdir -p "$HOME/.local/share/zinit" && chmod g-rwX "$HOME/.local/share/zinit"
  git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
  print -P "%F{33}%F{34}Installation successful.%f%b" ||
    print -P "%F{160}The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ──────────────────────────────────────────────────────────────────────────────
# 4) Initialize Zsh completion system *before* any completion plugins
# ──────────────────────────────────────────────────────────────────────────────
autoload -Uz compinit
compinit -u    # skip ownership checks

# ──────────────────────────────────────────────────────────────────────────────
# 5) Zinit‑managed plugins
# ──────────────────────────────────────────────────────────────────────────────
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode
zinit light zdharma-continuum/history-search-multi-word

# syntax highlighting must always come last
zinit light zsh-users/zsh-syntax-highlighting

# ──────────────────────────────────────────────────────────────────────────────
# 6) Starship prompt
# ──────────────────────────────────────────────────────────────────────────────
eval "$(starship init zsh)"

# ──────────────────────────────────────────────────────────────────────────────
# 7) Auto‑start tmux (only if not already inside one)
# ──────────────────────────────────────────────────────────────────────────────
if [[ -z $TMUX ]]; then
  exec tmux
fi
