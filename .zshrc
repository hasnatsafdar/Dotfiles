#     ███████╗ ███████╗ ██╗  ██╗ ██████╗   ██████╗     ██████╗  ██╗   ██╗     ██╗  ██╗  █████╗  ██╗  ██╗ ███╗   ██╗ ███████╗ ████████╗
#     ╚══███╔╝ ██╔════╝ ██║  ██║ ██╔══██╗ ██╔════╝     ██╔══██╗ ╚██╗ ██╔╝     ██║  ██║ ██╔══██╗ ╚██╗██╔╝ ████╗  ██║ ██╔════╝ ╚══██╔══╝
#       ███╔╝  ███████╗ ███████║ ██████╔╝ ██║          ██████╔╝  ╚████╔╝      ███████║ ███████║  ╚███╔╝  ██╔██╗ ██║ █████╗      ██║
#      ███╔╝   ╚════██║ ██╔══██║ ██╔══██╗ ██║          ██╔══██╗   ╚██╔╝       ██╔══██║ ██╔══██║  ██╔██╗  ██║╚██╗██║ ██╔══╝      ██║
# ██╗ ███████╗ ███████║ ██║  ██║ ██║  ██║ ╚██████╗     ██████╔╝    ██║        ██║  ██║ ██║  ██║ ██╔╝ ██╗ ██║ ╚████║ ███████╗    ██║
# ╚═╝ ╚══════╝ ╚══════╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝  ╚═════╝     ╚═════╝     ╚═╝        ╚═╝  ╚═╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝ ╚═╝  ╚═══╝ ╚══════╝    ╚═╝

# Directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# ╭──────────────────────────────────────────────╮
# │ Zinit Bootstrap (self-installing + portable) │
# ╰──────────────────────────────────────────────╯
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

PATH="$HOME/.go/bin:$PATH"

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# ╭──────────────────────────────────────────────╮
# │ History and Core Options                     │
# ╰──────────────────────────────────────────────╯
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ╭──────────────────────────────────────────────╮
# │ Plugins                                      │
# ╰──────────────────────────────────────────────╯
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=always $realpath'
zstyle 'completion:*' menu no
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons=always $realpath'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# ╭──────────────────────────────────────────────╮
# │ Prompt                                       │
# ╰──────────────────────────────────────────────╯
# Source Prompt
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# ╭──────────────────────────────────────────────╮
# │ Aliases                                      │
# ╰──────────────────────────────────────────────╯
alias ls='eza --icons=always'
alias l='eza -lh --icons --group-directories-first --color=always'
alias la='eza -a --icons --group-directories-first --color=always'
alias ll='eza -lah --icons --group-directories-first --color=always'
alias c='clear'
alias vim='nvim'
alias vi='nvim'
alias lg='lazygit'
alias ld='lazydocker'
alias ff='fastfetch --logo debian -c /usr/share/fastfetch/presets/examples/10.jsonc'
#alias pm='sudo pacman -S'
#alias pmnc='sudo pacman -S --noconfirm'

# Keybindings
#bindkey '`' autosuggest-accept
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Yazi setup
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Fancy ASCII
whoami() {
  local name
  name=$(command whoami)
  oh-my-logo "$name" ocean --filled --letter-spacing 1
}

oml() {
  oh-my-logo "$*" ocean --filled --letter-spacing 1
}
