source ~/antigen.zsh
if [[ -f ~/.proxy ]]; then source ~/.proxy; fi

# plugins
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

# theme
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
PURE_CMD_MAX_EXEC_TIME=999999999999

antigen apply

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt auto_list
setopt auto_menu

zstyle ':completion:*' menu select

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -e

export VISUAL=vim
export EDITOR=vim

# git aliases
alias g='git'
alias gs='git status -u'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gd='git diff'
alias gdc='git diff --cached'
alias gcl='git clean -fd'
alias gco='git checkout'
alias gl='git_pretty_log'
alias gst='git stash --include-untracked'

# ansible aliases
alias aa="ansible --vault-password-file .vault"
alias av="ansible-vault --vault-password-file .vault"
alias agi="ansible-galaxy install -r requirements.yml -f"
alias ap="agi; ansible-playbook -D --vault-password-file .vault"
alias aas="aa -m setup -a 'gather_subset=network' all"
alias avv="av view"
alias ave="av edit"
alias avc="av create"

# docker aliases
alias di='docker images'
alias dp='docker ps -a'
alias dc='docker stop $(docker ps -aq) && docker rm $(docker ps -aq)'

git_pretty_log() {
  FORMAT="tformat:%C(green)%h%C(reset) %C(yellow)%ar%C(reset) %C(bold blue)%an%C(reset) %C(bold red)%d%C(reset) %s"
  git log --color=always --graph --decorate --pretty=${FORMAT} $* |
  less -FXRS
}

# start in tmux
case $- in *i*)
  [ -z "$TMUX" ] && exec tmux
esac
