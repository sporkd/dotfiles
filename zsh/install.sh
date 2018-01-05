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

# Install zplug
if [ ! -f ~/.zplug/init.zsh ]
then
  echo "Installing zplug"
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

exit 0
