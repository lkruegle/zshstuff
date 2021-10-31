#!/bin/sh

# Install Tools
brew install neovim
brew install pure
brew install thefuck
brew install zsh-syntax-highlighting
brew install tree

# Symlink configurations
ln -s "$PWD/dotfiles/.zshrc" ~
ln -s "$PWD/config/nvim/init.vim" ~/.config/nvim
