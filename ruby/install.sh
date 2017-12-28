#!/bin/sh
#

# Create directories
if [ ! -d ~/.rbenv/plugins ]
then
  echo "  Creating rbenv plugins dir"
  mkdir -p ~/.rbenv/plugins
fi

# # Check for rbenv-default-gems
if [ ! -d ~/.rbenv/plugins/rbenv-default-gems ]
then
  echo "  Installing rbenv-default-gems plugin"
  git clone https://github.com/rbenv/rbenv-default-gems.git ~/.rbenv/plugins/rbenv-default-gems
fi

exit 0
