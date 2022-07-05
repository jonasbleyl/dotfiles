source ~/antigen.zsh
if [[ -f ~/.proxy ]]; then source ~/.proxy; fi

# plugins
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle mafredri/zsh-async
antigen apply

# prompt
PURE_CMD_MAX_EXEC_TIME=999999999999
fpath+=/opt/homebrew/share/zsh/site-functions
autoload -U promptinit; promptinit
prompt pure

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

# git aliases
alias gs='git status -u'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gd='git diff'
alias gdc='git diff --cached'
alias gcl='git clean -fd'
alias gco='git checkout'
alias gl='git_pretty_log'

# ansible aliases
alias ap='ansible-playbook -D --vault-password-file .vault'
alias avv='ansible-vault view --vault-password-file .vault'
alias ave='ansible-vault edit --vault-password-file .vault'
alias avc='ansible-vault create --vault-password-file .vault'

# docker aliases
alias dp='docker ps -a'
alias dc='docker stop $(docker ps -aq) && docker rm $(docker ps -aq)'

alias vim='mvim -v'

git_pretty_log() {
  FORMAT="tformat:%C(green)%h%C(reset) %C(yellow)%ar%C(reset) %C(bold blue)%an%C(reset) %C(bold red)%d%C(reset) %s"
  git log --color=always --graph --decorate --pretty=${FORMAT} $* |
  less -FXRS
}

export VISUAL=vim
export EDITOR=vim
export PATH="$PATH:/Users/bleyljd/go/bin"

eval "$(/opt/homebrew/bin/brew shellenv)"
