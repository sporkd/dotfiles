# Starship
if (( $+commands[starship] )); then
  if [ -f "$XDG_CONFIG_HOME/hooks/starship.toml" ]; then
    # hook to override default ~/.config/starship.toml
    export STARSHIP_CONFIG="$XDG_CONFIG_HOME/hooks/starship.toml"
  fi
  export STARSHIP_LOG="error" # silence timeout warnings
  eval "$(starship init zsh)"
fi
