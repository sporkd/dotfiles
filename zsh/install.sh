#!/bin/sh
#
# Add homebrew zsh to /etc/shells if it does not exist.
# Set default shell to zsh.

if ! grep -Fxq "/usr/local/bin/zsh" /etc/shells
then
  echo "updating /etc/shells"
  sudo echo "/usr/local/bin/zsh" >> /etc/shells
fi

if ! test "$(echo $SHELL)" = "/usr/local/bin/zsh"
then
  echo "changing shell to zsh"
  chsh -s /usr/local/bin/zsh
fi

exit 0
