# Correctly display UTF-8 with combining characters.
if [[ "$(locale LC_CTYPE)" == "UTF-8" ]]; then
    setopt COMBINING_CHARS
fi

# Disable the log builtin, so we don't conflict with /usr/bin/log
disable log

# ヒストリーに重複を表示しない
setopt histignorealldups
#ヒストリーをを保存
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=100000

# 左側のやつ
# export PROMPT="%m:%~ %#"
# Beep on error
setopt BEEP

# Use keycodes (generated via zkbd) if present, otherwise fallback on
# values from terminfo
if [[ -r ${ZDOTDIR:-$HOME}/.zkbd/${TERM}-${VENDOR} ]] ; then
    source ${ZDOTDIR:-$HOME}/.zkbd/${TERM}-${VENDOR}
else
    typeset -g -A key

  [[ -n "$terminfo[kf1]" ]] && key[F1]=$terminfo[kf1]
  [[ -n "$terminfo[kf2]" ]] && key[F2]=$terminfo[kf2]
  [[ -n "$terminfo[kf3]" ]] && key[F3]=$terminfo[kf3]
  [[ -n "$terminfo[kf4]" ]] && key[F4]=$terminfo[kf4]
  [[ -n "$terminfo[kf5]" ]] && key[F5]=$terminfo[kf5]
  [[ -n "$terminfo[kf6]" ]] && key[F6]=$terminfo[kf6]
  [[ -n "$terminfo[kf7]" ]] && key[F7]=$terminfo[kf7]
  [[ -n "$terminfo[kf8]" ]] && key[F8]=$terminfo[kf8]
  [[ -n "$terminfo[kf9]" ]] && key[F9]=$terminfo[kf9]
  [[ -n "$terminfo[kf10]" ]] && key[F10]=$terminfo[kf10]
  [[ -n "$terminfo[kf11]" ]] && key[F11]=$terminfo[kf11]
  [[ -n "$terminfo[kf12]" ]] && key[F12]=$terminfo[kf12]
  [[ -n "$terminfo[kf13]" ]] && key[F13]=$terminfo[kf13]
  [[ -n "$terminfo[kf14]" ]] && key[F14]=$terminfo[kf14]
  [[ -n "$terminfo[kf15]" ]] && key[F15]=$terminfo[kf15]
  [[ -n "$terminfo[kf16]" ]] && key[F16]=$terminfo[kf16]
  [[ -n "$terminfo[kf17]" ]] && key[F17]=$terminfo[kf17]
  [[ -n "$terminfo[kf18]" ]] && key[F18]=$terminfo[kf18]
  [[ -n "$terminfo[kf19]" ]] && key[F19]=$terminfo[kf19]
  [[ -n "$terminfo[kf20]" ]] && key[F20]=$terminfo[kf20]
  [[ -n "$terminfo[kbs]" ]] && key[Backspace]=$terminfo[kbs]
  [[ -n "$terminfo[kich1]" ]] && key[Insert]=$terminfo[kich1]
  [[ -n "$terminfo[kdch1]" ]] && key[Delete]=$terminfo[kdch1]
  [[ -n "$terminfo[khome]" ]] && key[Home]=$terminfo[khome]
  [[ -n "$terminfo[kend]" ]] && key[End]=$terminfo[kend]
  [[ -n "$terminfo[kpp]" ]] && key[PageUp]=$terminfo[kpp]
  [[ -n "$terminfo[knp]" ]] && key[PageDown]=$terminfo[knp]
  [[ -n "$terminfo[kcuu1]" ]] && key[Up]=$terminfo[kcuu1]
  [[ -n "$terminfo[kcub1]" ]] && key[Left]=$terminfo[kcub1]
  [[ -n "$terminfo[kcud1]" ]] && key[Down]=$terminfo[kcud1]
  [[ -n "$terminfo[kcuf1]" ]] && key[Right]=$terminfo[kcuf1]
fi

# Default key bindings
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search

# Default prompt
PS1="%n@%m %1~ %# "

# Useful support for interacting with Terminal.app or other terminal programs
[ -r "/etc/zshrc_$TERM_PROGRAM" ] && . "/etc/zshrc_$TERM_PROGRAM"
# PROMPT="%m %~ $ "
# Dockerのコマンドの補完
fpath=(~/.zsh/completion $fpath)
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# 補完
autoload -Uz compinit
# compinit
# 他のターミナルとヒストリーを共有
setopt share_history






if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
autoload -U compinit
compinit -u

# 補完の選択を楽にする
zstyle ':completion:*' menu select

# 補完候補をできるだけ詰めて表示する
setopt list_packed

# 補完候補に色つける
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true

# coddezで.zshrcを編集するようにする
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


#保管色付け
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
setopt auto_cd
function chpwd() { ls }

# PROMPT="%F{082}%m%f:%F{123}%b%~%b%f%# "
# RPROMPT=' %F{247} %D{%Y/%m/%d} %* %{$reset_color%}%f'
# RPROMPT='`rprompt-git-current-branch` %F{246} %D{%Y/%m/%d} %* %{$reset_color%}%f'
# RPROMPT='`rprompt-git-current-branch` '

#左側の$前の色
# PROMPT='%F{033}%m%f:%F{045}%b%c%b%f%# '

autoload -U colors; colors

# もしかして機能
setopt correct

# PCRE 互換の正規表現を使う
setopt re_match_pcre

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
# setopt prompt_subst

#Git
fpath=(~/.zsh $fpath)
if [ -f ${HOME}/.zsh/git-completion.zsh ]; then
      zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.zsh
fi
if [ -f ${HOME}/.zsh/git-prompt.sh ]; then
      source ${HOME}/.zsh/git-prompt.sh
fi
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto


# git ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない

    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="%F{014}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}


# プロンプトの右側にメソッドの結果を表示させる
RPROMPT=''
# RPROMPT='`rprompt-git-current-branch`'

# プロンプト指定
PROMPT='%F{198}[%n]%f %F{085}%D{%Y/%m/%d} %* `rprompt-git-current-branch` %{$reset_color%}%f%f%{${fg[yellow]}%}%~%{${reset_color}%} 
%(?.%{$fg[green]%}.%{$fg[blue]%})%(?!(*❛-❛) <!(*;-;%) <)%{${reset_color}%} '

# プロンプト指定(コマンドの続き)
# PROMPT2='[%n]> '

# もしかして時のプロンプト指定
SPROMPT="%{$fg[red]%}%{$suggest%}(*'~'%)? < もしかして %B%r%b %{$fg[red]%}かな? [そう!(y), 違う!(n),やっぱやーめた(a),もっかい書く!(e)]:${reset_color} "

alias szshrc="source ~/.zshrc"
# 文字コードの指定
export LANG=ja_JP.UTF-8
# autoload -Uz compinit; compinitautoload -Uz compinit; compinit

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
setopt prompt_subst           # プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt auto_param_slash       # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs              # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt auto_menu              # 補完キー連打で順に補完候補を自動で補完
setopt interactive_comments   # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst      # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt complete_in_word       # 語の途中でもカーソル位置で補完
setopt print_eight_bit        # 日本語ファイル名等8ビットを通す
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt share_history          # 他のターミナルとヒストリーを共有
setopt histignorealldups      # ヒストリーに重複を表示しない
setopt hist_save_no_dups      # 重複するコマンドが保存されるとき、古い方を削除する。
setopt extended_history       # $HISTFILEに時間も記録
setopt print_eight_bit        # 日本語ファイル名を表示可能にする
setopt hist_ignore_all_dups   # 同じコマンドをヒストリに残さない
setopt auto_cd                # ディレクトリ名だけでcdする
setopt no_beep                # ビープ音を消す
# コマンドを途中まで入力後、historyから絞り込み
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"



export PATH="/usr/local/opt/icu4c/bin:$PATH"



function allcolor() { 
  for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
}
function cpwd() { 
  pwd | pbcopy
  pwd 
}

alias oniterm="open -a iTerm . "
# for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
# for c in {000..1000}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
# 色を256色で表示するやつ

# プロンプト指定(コマンドの続き)
# PROMPT2='[%n]> '





# ZSH_THEME="cobalt2"

eval "$(rbenv init -)"
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"

  #関数定義(引数3つ)
#タブの色を変更する

function chpwd() { echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print $1}'| rev)\007"}


# zle -N accept-line re-prompt


function google() {
  local str opt
  if [ $# != 0 ]; then
      for i in $*; do
        str="$str+$i"
      done
      str=`echo $str | sed 's/^\+//'`
      opt='search?num=50&hl=ja&lr=lang_ja'
      opt="${opt}&q=${str}"
    fi
    w3m http://www.google.co.jp/$opt
}
export PATH="$PATH:/opt/yarn-[version]/bin"

export PATH="$PATH:`yarn global bin`"
export PATH="/usr/local/bin:$PATH"

# Hyper の設定
# Override auto-title when static titles are desired ($ title My new title)
title() { export TITLE_OVERRIDDEN=1; echo -en "\e]0;$*\a"}
# Turn off static titles ($ autotitle)
autotitle() { export TITLE_OVERRIDDEN=0 }; autotitle
# Condition checking if title is overridden
overridden() { [[ $TITLE_OVERRIDDEN == 1 ]]; }
# Echo asterisk if git state is dirty
gitDirty() { [[ $(git status 2> /dev/null | grep -o '\w\+' | tail -n1) != ("clean"|"") ]] && echo "*" }

# Show cwd when shell prompts for input.
precmd() {
  if overridden; then return; fi
  cwd=${$(pwd)##*/} # Extract current working dir only
  print -Pn "\e]0;$cwd$(gitDirty)\a" # Replace with $pwd to show full path
}

# Prepend command (w/o arguments) to cwd while waiting for command to complete.
preexec() {
  if overridden; then return; fi
  printf "\033]0;%s\a" "${1%% *} | $cwd$(gitDirty)" # Omit construct from $1 to show args
}
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export ANDROID_SDK=/Users/sutomoyuru/Library/Android/sdk
export PATH=/Users/sutomoyuru/Library/Android/sdk/platform-tools:$PATH

# source /Users/sutomoyuru/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# 
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools


export PATH="$PATH:`pwd`/flutter/bin"
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-wakatime/zsh-wakatime.plugin.zsh


# source /Users/sutomoyuru/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export JAVA_HOME="/usr/libexec/java_home -v 11.0.2"
# Dockerのコマンドの補完
# fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i


PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="/Users/mochi/.deno/bin:$PATH"
eval "$(gh completion -s zsh)"

# alias ls='exa'
# alias cat='bat'
# alias ps='procs'
# alias grep='rg'
# # alias find='fd'
# alias od='hexyl'
# alias wc='tokei'

eval "$(anyenv init -)"

export PATH="$PATH:$HOME/development/flutter/bin"

export PATH=$HOME/.cargo/bin:$PATH
# source $HOME/.cargo/env

cdf() {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]; then
    cd "$target"; pwd
  else
    echo 'No Finder window found' >&2
  fi
}
source $HOME/.cargo/env