# prepend asdf to path if .tool_versions
function _asdf_chpwd() {
  emulate -L zsh

  if [ -f ".tool-versions" -a "$PWD" != "$HOME" ]; then
    if [ -f "$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh" ]; then
      # source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh
      plugins="$(asdf plugin list)"
      while IFS= read -r line; do
        [[ $line =~ ^[[:blank:]]*(#.*)?$ ]] && continue
        read -rA parts <<<"$line"
        plugin=$parts[1]
        version=$parts[2]
        if [[ $plugin && $version ]]; then
          echo
          if ! grep -q $plugin <<< "$plugins" ; then
            echo "Adding $plugin plugin..."
            asdf plugin-add $plugin
            [ $? -ne 0 ] && continue
          else
            echo "Using $plugin plugin..."
          fi
          asdf list $plugin $version &> /dev/null
          if [ $? -ne 0 ]; then
            versions="$(asdf list all $plugin)"
            if grep -q $version <<< "$versions" ; then
              echo "installing $plugin $version..."
              asdf install $plugin $version
            else
              echo "No compatible version found for $plugin $version"
            fi
          else
            echo "$plugin $version already installed"
          fi
        fi
      done < "$PWD/.tool-versions"
    fi
    # pkgx env reload bug
    env &> /dev/null
  fi
}
chpwd_functions=(${chpwd_functions[@]} "_asdf_chpwd")
