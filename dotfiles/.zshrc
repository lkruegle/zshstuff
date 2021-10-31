PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:$HOME/google-cloud-sdk/bin:${PATH}"
export PATH

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
alias gocat="cd ~/code/catalant"
alias gohome="cd ~"
# automatically run format then test
alias autotest="ct format && ct test"

newb() {
    if [ -n "$1" ]
    then
        git checkout master && git pull
        git checkout -b "$1"
    fi
}

# open ~/.zshrc in using the default editor specified in $EDITOR
alias ec="nvim $HOME/.zshrc"
# source ~/.zshrc
alias sc="source $HOME/.zshrc"

autoload -Uz compinit && compinit -u

# enable syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# enable vim mode
# bindkey -v

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
