# =============================================================================
# Powerlevel10k instant prompt
# Keep this as close to the top as possible.
# =============================================================================

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# =============================================================================
# Environment
# =============================================================================

export ZSH="$HOME/.oh-my-zsh"

# Locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Editors
if [[ -n "$SSH_CONNECTION" ]]; then
  export EDITOR="nvim"
  export VISUAL="nvim"
else
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

# Pager
export PAGER="less"
export LESS="-R"

# User binaries
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"


# =============================================================================
# Oh My Zsh
# =============================================================================

ZSH_THEME="powerlevel10k/powerlevel10k"

# Completion
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"

# Disable features we don't need
DISABLE_AUTO_UPDATE="true"
DISABLE_CORRECTION="true"

# Plugins
plugins=(
  git
  zsh-autosuggestions
)

source "$ZSH/oh-my-zsh.sh"


# =============================================================================
# Syntax highlighting
# =============================================================================

# Load this AFTER Oh My Zsh.
if [[ -f "${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi


# =============================================================================
# History
# =============================================================================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY


# =============================================================================
# Completion
# =============================================================================

autoload -Uz compinit
compinit

# Better completion behavior
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''


# =============================================================================
# PATH / local environment
# =============================================================================

if [[ -f "$HOME/.local/bin/env" ]]; then
  source "$HOME/.local/bin/env"
fi


# =============================================================================
# uv
# =============================================================================

if command -v uv >/dev/null 2>&1; then
  eval "$(uv generate-shell-completion zsh)"
fi

if command -v uvx >/dev/null 2>&1; then
  eval "$(uvx --generate-shell-completion zsh)"
fi


# =============================================================================
# Aliases
# =============================================================================

alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias c='clear'

alias zshconfig='${EDITOR:-nvim} ~/.zshrc'
alias p10kconfig='${EDITOR:-nvim} ~/.p10k.zsh'

alias reload='source ~/.zshrc'


# =============================================================================
# Git
# =============================================================================

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gca='git commit --amend'
alias gp='git push'
alias gpl='git pull'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate'
alias gco='git checkout'
alias gsw='git switch'
alias gb='git branch'


# =============================================================================
# Useful functions
# =============================================================================

mkcd() {
  mkdir -p -- "$1" && cd -- "$1"
}

extract() {
  if [[ ! -f "$1" ]]; then
    echo "File not found: $1"
    return 1
  fi

  case "$1" in
    *.tar.bz2) tar xjf "$1" ;;
    *.tar.gz)  tar xzf "$1" ;;
    *.bz2)     bunzip2 "$1" ;;
    *.rar)     unrar x "$1" ;;
    *.gz)      gunzip "$1" ;;
    *.tar)     tar xf "$1" ;;
    *.tbz2)    tar xjf "$1" ;;
    *.tgz)     tar xzf "$1" ;;
    *.zip)     unzip "$1" ;;
    *.Z)       uncompress "$1" ;;
    *.7z)      7z x "$1" ;;
    *)         echo "Don't know how to extract '$1'" ;;
  esac
}


# =============================================================================
# Powerlevel10k
# =============================================================================

[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"
