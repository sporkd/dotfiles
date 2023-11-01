plugins="$(asdf plugin list)"
while IFS= read -r line; do
  [[ $line =~ ^[[:blank:]]*(#.*)?$ ]] && continue
  read -rA parts <<<"$line"
  plugin=$parts[1]
  version=$parts[2]
  if [[ $plugin && $version ]]; then
    echo
    if [[ "$plugin" = "ruby" ]]; then
      # Remove pkgx ruby and rubygems from PATH
      if [[ "$(command -v env)" = "env" ]]; then
        env -ruby-lang.org -rubygems.org
      fi
    fi
    if [[ "$plugin" = "nodejs" ]]; then
      # Remove pkgx node and npm from PATH
      if [[ "$(command -v env)" = "env" ]]; then
        env -nodejs.org -npmjs.com
      fi
    fi

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
        # Turn off pkgx dev before install
        dev_on=false
        if type _pkgx_dev_off > /dev/null 2>&1; then
          dev_on=true
          _pkgx_dev_off
        fi
        echo
        echo "installing $plugin $version..."
        asdf install $plugin $version
        # Turn pkgx dev back on
        if $dev_on; then
          [[ "$(command -v dev)" = "dev" ]] && dev
        fi
      else
        echo "No compatible version found for $plugin $version"
      fi
    else
      echo "$plugin $version already installed"
    fi

    # Install bundler version in Gemfile.lock
    # if [[ "$plugin" = "ruby" && -f "$PWD/Gemfile.lock" ]]; then
    #   output=$(bundle doctor 2>&1)
    #   symver=$(echo "$output" | grep -Eo "\`gem install bundler:(.*)\`" | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+')
    #   if [[ -n "$symver" && $(gem info -i -v ${symver} bundler) = 'false' ]]; then
    #     echo
    #     echo "Installing bundler v$symver..."
    #     result=$(asdf exec gem install bundler:${symver})
    #     echo "$result"
    #   fi
    # fi
  fi
done < "{{ .dir }}/.tool-versions"
