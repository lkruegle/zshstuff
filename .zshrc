
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

autoload -U promptinit; promptinit
prompt pure

eval $(thefuck --alias)

alias dbranch="git branch -D"
alias ll="ls -l"
alias ..="cd .."
alias ...="cd ../.."
alias clean_branches="git checkout master && git pull && git branch --merged master | grep -v \"\* master\" | xargs -n 1 git branch -d"
alias gocat="cd ~/code/catalant"
alias gohome="cd ~"

newb() {
    if [ -n "$1" ]
    then
        git checkout -b "$1"
    fi
}

# open ~/.zshrc in using the default editor specified in $EDITOR
alias ec="vim ~/.zshrc"

# source ~/.zshrc
alias sc="source $HOME/.zshrc"

autoload -Uz compinit && compinit -u

# enable syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


