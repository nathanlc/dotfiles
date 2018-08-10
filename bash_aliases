alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'
alias o='open'
alias s='for i in {1..15}; do echo; done' # Create some space in the terminal
alias cl='cd && clear'
alias cp='cp -iv'
alias mv='mv -iv'
alias ls='ls -G'
alias ll='ls -AFGhl'
alias llg='ls -AFGhl | grep --color -i'
alias lt='ls -AFGhlrt'
alias lt1='ls -FGrt | tail -1'
alias cat1='cat $(lt1)'
alias less1='less -S $(lt1)'
alias dc='docker-compose'
alias dx='docker-compose exec'
alias ec='emacsclient -nc'
alias tmuxat='tmux a -t'
alias psg='ps aux | grep --color -i'
alias zz='pmset sleepnow'