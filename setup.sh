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
    ln -s "$PWD/dotfiles/.zshrc" "$HOME/.zshrc";
else
    echo ".zshrc already exists. Remove it to replace."
fi

if ! [[ -L "$HOME/.config/nvim/init.vim" ]]; then
    # TODO: Figure out how to auto create these dirs if they don't exist
    # mkdir "$HOME/.config/nvim"
    ln -s "$PWD/config/nvim/init.vim" "$HOME/.config/nvim/init.vim"
else
    echo ".config/nvim/init.vim already exists. Remove it to replace."
fi
