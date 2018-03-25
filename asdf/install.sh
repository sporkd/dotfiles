#!/bin/sh
#
# asdf

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Check for asdf
if brew ls --versions asdf > /dev/null; then
  echo "Updating asdf plugins..."
  asdf plugin-update --all

  echo "Installing asdf plugins..."
  INSTALLED="$(asdf plugin-list)"
  PLUGINS="$(dirname "$0")/plugins"

  if [ -f ${PLUGINS} ]; then
    while read LINE
    do
      case "$LINE" in \#*) continue ;; esac
      IFS=' ' read -a plugin <<< "$LINE"
      if [ ${plugin[0]} ]; then
        if ! grep -q ${plugin[0]} <<< "$INSTALLED" ; then
          if [ ${plugin[1]} ]; then
            printf "${GREEN}Installing plugin ${plugin[0]}${NC} from ${plugin[1]}\n"
            asdf plugin-add ${plugin[0]} ${plugin[1]}
          else
            printf "${GREEN}Installing plugin ${plugin[0]}${NC}\n"
            asdf plugin-add ${plugin[0]}
          fi

          # Import NodeJs OpenPGP keys to main keyring
          if [ "${plugin[0]}" = 'nodejs' ]; then
            echo "Importing OpenPGP keys for nodejs..."
            source /usr/local/opt/asdf/plugins/nodejs/bin/import-release-team-keyring
          fi
        else
          echo "Using ${plugin[0]}"
        fi
      fi
    done < ${PLUGINS}
  else
    printf "${RED}Could not find ${PLUGINS}${NC}\n"
  fi
fi

exit 0
