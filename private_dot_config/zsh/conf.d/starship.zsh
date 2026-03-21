# Initialize Starship
if (( $+commands[starship] )); then
    local config_dir="$XDG_CONFIG_HOME/starship"
    local config_file="$config_dir/current.toml"

    if [[ ! -f "$config_file" ]]; then
        config_file="$config_dir/default.toml"
    fi

    if [[ -f "$config_file" ]]; then
        export STARSHIP_CONFIG="$config_file"
    fi

    # Silence timeout warnings
    export STARSHIP_LOG="error"

    eval "$(starship init zsh)"
fi

