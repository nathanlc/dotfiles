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
SAVEHIST=5000
HISTSIZE=2000
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
alias -g ...='cd ../..'
alias -g ....='cd ../../..'
alias -g cp='cp -iv'
alias -g mv='mv -iv'
alias -g ll='ls -AlhF --color=always --group-directories-first'
alias -g ls='ls -AF --color=always --group-directories-first'
alias -g lt='ls -AlhFrt --color=always'
alias -g hist='history -i'
alias dc='docker compose'
alias dx='docker compose exec'
alias gb='git branch --list'
alias gc='git checkout'
alias gd='git diff'
alias gs='git status'
alias gl='git log --oneline --decorate --graph'
alias gfa='git fetch --all'
alias gwl='git worktree'
alias gwa='git worktree add'
alias gwr='git worktree remove'
alias o='open'
alias psg='ps aux | grep --color -i'
alias tmuxat='tmux a -t'
alias vim='nvim'
alias vimu='nvim --clean'
alias s='for i in {1..15}; do echo; done' # Create some space in the terminal
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
alias mc='mutagen-compose'
# alias zz='pmset sleepnow'
# alias dnd="bash $SCRIPTS/do_not_disturb_toggle.sh"
# alias f="bash $SCRIPTS/search-firefox-history.sh"
# Aliases END

# Completion START
autoload -Uz compinit && compinit
# Case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 
# Partial completion suggestions
zstyle ':completion:*' list-suffixes zstyle ':completion:*' expand prefix suffix 
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
export EDITOR="nvim"
export LESS="-SXR"
export XDG_CONFIG_HOME="$HOME/.config"
# Starship START
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
eval "$(starship init zsh)"
# Starship END
export XDG_DATA_HOME="$HOME/.local/share"
# Go START
export GOPATH="$HOME/sandbox/mine/go"
export GOROOT="/usr/local/go"
PATH="${GOPATH}/bin:${GOROOT}/bin:$PATH"
# Go END
PATH="$HOME/.local/bin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/usr/local/opt:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
PATH="/opt/local/bin:/opt/local/sbin:$PATH"
PATH="$SCRIPTS:$PATH"
PATH="$SCRIPTS/diasend:$PATH"
PATH="$SCRIPTS/glooko:$PATH"
PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
PATH="/opt/homebrew/opt/libpq/bin:$PATH"
# Java START
PATH="$HOME/.jenv/bin:$PATH"
PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# Java END
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
# FZF START
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# FZF END
. "$HOME/.cargo/env"
