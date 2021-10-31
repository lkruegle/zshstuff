#!/bin/sh

# Install packages
PACKAGES=$(cat "packages.txt")
for pkg in $PACKAGES; do
    if brew ls --versions $pkg > /dev/null; then
        echo "Package '$pkg' is already installed";
    else
        echo "installing '$pkg':";
        brew install $pkg;
    fi
done

# Symlink configurations
if ! [[ -L "$HOME/.zshrc" ]]; then
    ln -s "$PWD/dotfiles/.zshrc" $HOME;
else
    echo ".zshrc already exists. Remove it to replace."
fi

if ! [[ -L "$HOME/.config/nvim/init.vim" ]]; then
    ln -s "$PWD/config/nvim/init.vim" "$HOME/.config/nvim"
else
    echo ".config/nvim/init.vim already exists. Remove it to replace."
fi
