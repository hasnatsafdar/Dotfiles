#     ███████╗ ███████╗ ██╗  ██╗ ██████╗   ██████╗     ██████╗  ██╗   ██╗     ██╗  ██╗  █████╗  ██╗  ██╗ ███╗   ██╗ ███████╗ ████████╗
#     ╚══███╔╝ ██╔════╝ ██║  ██║ ██╔══██╗ ██╔════╝     ██╔══██╗ ╚██╗ ██╔╝     ██║  ██║ ██╔══██╗ ╚██╗██╔╝ ████╗  ██║ ██╔════╝ ╚══██╔══╝
#       ███╔╝  ███████╗ ███████║ ██████╔╝ ██║          ██████╔╝  ╚████╔╝      ███████║ ███████║  ╚███╔╝  ██╔██╗ ██║ █████╗      ██║
#      ███╔╝   ╚════██║ ██╔══██║ ██╔══██╗ ██║          ██╔══██╗   ╚██╔╝       ██╔══██║ ██╔══██║  ██╔██╗  ██║╚██╗██║ ██╔══╝      ██║
# ██╗ ███████╗ ███████║ ██║  ██║ ██║  ██║ ╚██████╗     ██████╔╝    ██║        ██║  ██║ ██║  ██║ ██╔╝ ██╗ ██║ ╚████║ ███████╗    ██║
# ╚═╝ ╚══════╝ ╚══════╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝  ╚═════╝     ╚═════╝     ╚═╝        ╚═╝  ╚═╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝ ╚═╝  ╚═══╝ ╚══════╝    ╚═╝

# ╭──────────────────────────────────────────────╮
# │ Zinit Bootstrap (self-installing + portable) │
# ╰──────────────────────────────────────────────╯
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -f "${ZINIT_HOME}/zinit.zsh" ]]; then
  echo "[zsh] Installing Zinit..." >&2
  mkdir -p "$(dirname "${ZINIT_HOME}")"
  if ! command -v git >/dev/null 2>&1; then
    echo "[zsh] Error: git is not installed. Please install git to use Zinit." >&2
    return 1
  fi
  if ! git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}" >/dev/null 2>&1; then
    echo "[zsh] Error: Failed to clone Zinit repository." >&2
    return 1
  fi
fi
if [[ -f "${ZINIT_HOME}/zinit.zsh" ]]; then
  source "${ZINIT_HOME}/zinit.zsh"
else
  echo "[zsh] Error: Zinit not found at ${ZINIT_HOME}/zinit.zsh" >&2
fi

# ╭──────────────────────────────────────────────╮
# │ History and Core Options                     │
# ╰──────────────────────────────────────────────╯
# History Settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# History Options
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
# ╭──────────────────────────────────────────────╮
# │ Aliases                                      │
# ╰──────────────────────────────────────────────╯
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons=always'
  alias l='eza -lh --icons --group-directories-first --color=always'
  alias la='eza -a --icons --group-directories-first --color=always'
  alias ll='eza -lah --icons --group-directories-first --color=always'
fi
alias c='clear'
alias vim='nvim'
alias vi='nvim'
alias pm='sudo pacman -S'
alias pmnc='sudo pacman -S --noconfirm'
alias lg='lazygit'
alias ff='fastfetch --logo debian -c /usr/share/fastfetch/presets/examples/10.jsonc'
# Yazi setup
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# ╭──────────────────────────────────────────────╮
# │ Vim Keybindings                              │
# ╰──────────────────────────────────────────────╯
bindkey -v
export KEYTIMEOUT=1

# ╭──────────────────────────────────────────────╮
# │ Plugins                                      │
# ╰──────────────────────────────────────────────╯
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
#zinit light Aloxaf/fzf-tab

# ╭──────────────────────────────────────────────╮
# │ Starship Prompt                              │
# ╰──────────────────────────────────────────────╯

eval "$(starship init zsh)"

# Fancy ASCII
whoami() {
  local name
  name=$(command whoami)
  oh-my-logo "$name" ocean --filled --letter-spacing 1
}

ohmylogo() {
  oh-my-logo "$*" ocean --filled --letter-spacing 1
}
