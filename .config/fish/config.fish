set -g theme_display_git_master_branch yes  # git の branch 名を表示

alias codez='code ~/.zshrc'
alias vimz='vim ~/.zshrc'

alias pwdcopy="pwd | pbcopy"

alias vms="sh /Users/sutomoyuru/vagrant/vagrant-start.sh"


# aliasたち
alias lsg="ls -G -w"
alias gls="gls --color"
alias where="command -v"
alias j="jobs -l"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias g='git'
alias gb='git branch'
alias gl='git log --pretty=format:"%C(yellow)%h%Creset %C(magenta)%ci%Creset%n%C(cyan)%an <%ae>%Creset%n%B"'
alias glp='git log -p'
alias glg='git log --graph --pretty=format:"%C(yellow)%h%Creset %C(magenta)%ci%Creset%n%C(cyan)%an <%ae>%Creset%n%B"'
alias gco='git checkout'
alias gd='git diff'
alias gdh='git diff HEAD'
alias gds='git diff --stat'
alias gdt='git difftool'
alias gst='git status'
alias gp='git pull'

alias du="du -h"
alias df="df -h"


alias su="su -l"

alias dc="docker-compose"
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dcr='docker-compose restart'
alias dce='docker-compose exec'
alias dp='docker ps'
alias dx='docker exec '


alias lss="exa"

alias python="python3"

alias compete="cargo compete"




export PATH="/usr/local/opt/icu4c/bin:$PATH"

function cpwd
  pwd | pbcopy
  pwd 
end