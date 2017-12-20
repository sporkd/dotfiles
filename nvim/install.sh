#!/bin/sh
#
# Install neovim dependencies

# Check for vim-plug
if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]
then
  echo "  Installing vim-plug"
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

exit 0
