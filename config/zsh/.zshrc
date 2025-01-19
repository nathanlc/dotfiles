# Do not enable Ctrl-s to stop I/O in terminal
stty -ixon

# Setup emacs keybindings
bindkey -e

# No need to write cd to change directory
setopt AUTO_CD
# Make globs case-insensitives
setopt NO_CASE_GLOB

# Create a history file
HISTFILE=${ZDOTDIR}/.zsh_history
# Add more info for each history entry
setopt EXTENDED_HISTORY
# Remember number of commands in session and file
SAVEHIST=500000
HISTSIZE=500000
# Share history across multiple zsh
setopt SHARE_HISTORY
# Append to history
setopt APPEND_HISTORY
# Adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# Expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST 
# Do not store duplications
setopt HIST_IGNORE_DUPS
# Ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# Removes blank lines from history
setopt HIST_REDUCE_BLANKS
# Verify command taken from history
setopt HIST_VERIFY

# Correct typos in commands
setopt CORRECT

# Aliases START
alias cp='cp -iv'
alias mv='mv -iv'
alias ll='ls -AlhF --color=always --group-directories-first'
alias ls='ls -AF --color=always --group-directories-first'
alias lt='ls -AlhFrt --color=always'
alias ...='cd ../..'
alias ....='cd ../../..'
alias hist='history -i'
alias dc='docker compose'
alias dx='docker compose exec'
alias gb='git branch --list'
alias gc='git checkout'
alias gd='git diff'
alias gs='git status'
alias gl='git log --oneline --decorate --graph'
alias gfa='git fetch --all'
alias gwl='git worktree list'
alias gwa='git worktree add'
alias gwr='git worktree remove'
alias o='open'
alias psg='ps aux | grep --colour -i'
alias tmuxat='tmux a -t'
alias s='for i in {1..15}; do echo; done' # Create some space in the terminal
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
alias mc='mutagen-compose'
alias mx='mutagen-compose exec'
alias vc='nvim --clean'
# alias vs='nvim --listen /tmp/nvimsocket'
# alias v='nvr'
alias gcs='gh copilot suggest'
alias gce='gh copilot explain'
# alias zz='pmset sleepnow'
# alias dnd="bash $SCRIPTS/do_not_disturb_toggle.sh"
# alias f="bash $SCRIPTS/search-firefox-history.sh"
# Aliases END

# Completion START
autoload -Uz compinit && compinit
# Use zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# Partial completion suggestions
zstyle ':completion:*' list-suffixes zstyle ':completion:*' expand prefix suffix
# Load bashcompinit for some old bash completions
autoload bashcompinit && bashcompinit
# Completion END

# Word delimiters in zsh
export WORDCHARS="${WORDCHARS/\/}"

# asdf START
. "$HOME/.asdf/asdf.sh"
# asdf END
export ORG="$HOME/Dropbox/org"
export SCRIPTS="$HOME/sandbox/scripts"
export EDITOR="nvr"
export LESS="-SXR"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export JIRA_API_TOKEN=ATATT3xFfGF0fnw-URTheLdzCNJTY84zsACRQK65n2ZVeGot0Y5FNfKdS275_C4GM8-wuZpvclXVpVEBHeepi7xH67688NnhzGndhW9mrXnWx-s8bCUvIE2SX5f2Xpf6wsQst8CxwUMo6Gw6gf94LHYNK-XBhwUb_HKSd_4I1L9mDyyzDE3TZCU=6EEB9995
# ripgrep START
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"
# ripgrep END
# Go START
export GOPATH="$HOME/go"
PATH="${GOPATH}/bin:$PATH"
# Go END
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/bin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/usr/local/opt:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
PATH="/opt/local/bin:/opt/local/sbin:$PATH"
PATH="$SCRIPTS:$PATH"
PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
PATH="/opt/homebrew/opt/libpq/bin:$PATH"
# Java START
PATH="$HOME/.jenv/bin:$PATH"
PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# Starship START
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
eval "$(starship init zsh)"
# Starship END
# Java END
# Bun START
export BUN_INSTALL="$HOME/.bun"
PATH="$BUN_INSTALL/bin:$PATH"
# Flutter START
export FLUTTER_ROOT="$(asdf where flutter)"
# Flutter END
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
MANPATH="/opt/local/share/man:$MANPATH"
MANPATH="/opt/homebrew/share/man:$MANPATH"
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export PATH
export MANPATH
# Java START
eval "$(jenv init -)"
# Java END
# Node START
export NODE_PATH=$(which node)
# Node END
# Docker / docker compose START
export COMPOSE_MENU=0
# END
# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Cargo
. "$HOME/.cargo/env"
# Atuin
eval "$(atuin init zsh)"
# zoxide
eval "$(zoxide init zsh)"

# bun completions
[ -s "/Users/nathan/.bun/_bun" ] && source "/Users/nathan/.bun/_bun"
