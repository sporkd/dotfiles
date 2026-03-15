# Starship
if (( $+commands[starship] )); then
  if [ -f "$HOME/.config/hooks/starship.toml" ]; then
    # hook to override default ~/.config/starship.toml
    export STARSHIP_CONFIG="$HOME/.config/hooks/starship.toml"
  fi
  export STARSHIP_LOG="error" # silence timeout warnings
  eval "$(starship init zsh)"
fi

