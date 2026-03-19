# Implode RVM if installed
if command -v rvm >/dev/null 2>&1; then
  echo
  _print_danger "An installation of RVM was deteced on your system which will conflict"
  _print_danger "with mise's Ruby installation. We'll run 'rvm implode' to remove it."
  if [[ "${backed_up:-false}" == "true" ]] && [[ -n "${${(@)verified_list}:#^*.rvm*}" ]]; then
    _print_danger ""
    _print_danger "Don't worry, we just backed up your ~/.rvm directory😉"
  else
    _print_danger ""
    _print_danger "Don't worry, you don't need RVM anymore😉"
  fi
  _print_danger ""
  _print_danger "If for some reason this fails, you may need to remove it manually"
  _print_danger "and rerun this script with the follwing commands:"

  echo
  _print_cmd "rvm implode"
  echo "(open new terminal)"
  _print_cmd "chezmoi apply"

  echo
  _prompt -p "Continue? [Y|n] " -d "Y" resp
  if [[ $resp =~ ^(y|yes|Y) ]]; then
    _print_running "rvm implode"
    rvm implode --force
  else
    _print_error "Aborting..."
    exit 1
  fi
fi
