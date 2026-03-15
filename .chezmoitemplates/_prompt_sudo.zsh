function _prompt_sudo() {
  # Check if we already have sudo privileges
  # -n (non-interactive) will exit with an error if a password is required
  if ! sudo -n true 2>/dev/null; then
    echo
    if ! sudo -v -p "Password required for %u: "; then
        echo
        _print_error "Authentication failed. Exiting."
        exit 1
    fi
  fi
}
