set -g theme_display_git_master_branch yes  # git の branch 名を表示

alias codez='code ~/.zshrc'
alias codef='code ~/.config/fish/'
alias sfish='source ~/.config/fish/config.fish'

alias vimz='vim ~/.zshrc'

alias pwdcopy="pwd | pbcopy"

alias vms="sh ~/vagrant/vagrant-start.sh"


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
alias glg='git log --graph --pretty=format:"%C(yellow)%h% Creset %C(magenta)%ci%Creset%n%C(cyan)%an <%ae>%Creset%n%B"'
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
alias vim="nvim"
alias dc="docker compose "
alias dcu='docker compose  up -d'
alias dcd='docker compose  down'
alias dcr='docker compose  restart'
alias dce='docker compose  exec'
alias dp='docker ps'
alias dx='docker exec '


alias lss="exa"

alias python="python3"

alias compete="cargo compete"





export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

function cpwd
  pwd | pbcopy
  pwd 
end


# set -x PATH $HOME/.nodebrew/current/bin $PATH

# set -x PATH "$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin $PATH"
# set -x $HOME /.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin
# set -x $HOME /.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin

# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# export ANDROID_SDK=/Users/sutomoyuru/Library/Android/sdk
# export PATH=/Users/sutomoyuru/Library/Android/sdk/platform-tools:$PATH

# source /Users/sutomoyuru/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# 
# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/tools/bin
# export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH="$PATH:`pwd`/flutter/bin"


# export JAVA_HOME="/usr/libexec/java_home -v 11.0.2"
# # Dockerのコマンドの補完
# # fpath=(~/.zsh/completion $fpath)
# autoload -Uz compinit && compinit -i


export PATH="/Users/mochi/.deno/bin:$PATH"

# export PATH="/Users/mochi/.deno/bin:$PATH"
export PATH="$PATH:$HOME/development/flutter/bin"

# export PATH=$HOME/.cargo/bin:$PATH
# source $HOME/.cargo/env

# source $HOME/.cargo/env

export PATH="$HOME/.cargo/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mochi/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/mochi/Downloads/google-cloud-sdk/path.fish.inc'; end

status --is-interactive; and source (rbenv init -|psub)
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

export LSCOLORS=Gxfxcxdxbxegedabagacad
# 文字を見やすくすする
