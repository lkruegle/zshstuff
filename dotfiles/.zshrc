PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

export EDITOR=nvim
export GIT_EDITOR=$EDITOR

autoload -U promptinit; promptinit
prompt pure

eval $(thefuck --alias)
alias asdflkjasdf="fuck"

alias ll="ls -l"
alias la="ls -la"
alias ..="cd .."
alias ...="cd ../.."
alias dmerb="git checkout master && git pull && git branch --merged master | grep -v \"\* master\" | xargs -n 1 git branch -d"
alias dtmpb="git checkout master && git branch | grep \"tmp\" | xargs -n 1 git branch -d"
alias gohome="cd ~"
# automatically run format then test
alias autotest="ct format && ct test"

fb() {
    git branch | fzf | tr -d '[:space:]*'
}

gch() {
    git checkout $(fb)
}

newb() {
    if [ -n "$1" ]
    then
        git checkout master && git pull
        git checkout -b "$1"
    fi
}

# open ~/.zshrc in using the default editor specified in $EDITOR
alias ec="$EDITOR $HOME/.zshrc"
# source ~/.zshrc
alias sc="source $HOME/.zshrc"

autoload -Uz compinit && compinit -u

# enable syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# enable vim mode
# bindkey -v

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.zshrc_local
