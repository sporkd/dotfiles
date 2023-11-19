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
      _print_lib asdf  "adding $plugin plugin"
      asdf plugin-add $plugin
      [ $? -ne 0 ] && continue
    else
      _print_lib asdf  "using $plugin plugin"
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

        if [[ "{{ .dir }}" = "$HOME" ]]; then
          _print_lib asdf  "installing $plugin $version"
          asdf install $plugin $version
          _print_ok
        else
          _print_lib asdf  "This project requires $plugin $version"
          _prompt -p "Install? [Y|n] " -d "Y" response
          if [[ $response =~ ^(y|yes|Y) ]]; then
            echo
            _print_lib asdf  "installing $plugin $version"
            asdf install $plugin $version

            echo
            if [ $? -eq 0 ]; then
              _print_ok "Success!"
            else
              _print_error "Something went wrong"
            fi
          else
            echo
            _print_skipping
          fi
        fi

        # Turn pkgx dev back on
        if $dev_on; then
          [[ "$(command -v dev)" = "dev" ]] && dev
        fi
      else
        _print_warn "No compatible version found for $plugin $version"
      fi
    else
      _print_lib asdf  "$plugin $version already installed"
    fi

    # # Install bundler version in Gemfile.lock
    # if [[ "$plugin" = "ruby" && -f "$PWD/Gemfile.lock" ]]; then
    #   symver="$(grep -A 1 "BUNDLED WITH" $PWD/Gemfile.lock | tail -n 1 | awk '{$1=$1};1')"
    #   if [[ -n "$symver" && $(asdf exec gem info -i -v ${symver} bundler) = 'false' ]]; then
    #     echo
    #     _print_installing "bundler v$symver"
    #     result=$(asdf exec gem install bundler -v ${symver})
    #     _print_ok "$result"
    #   fi
    # fi
  fi
done < "{{ .dir }}/.tool-versions"
