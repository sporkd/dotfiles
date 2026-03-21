# Starship Initialization
if type -q starship
    set -l config_dir "$XDG_CONFIG_HOME/starship"
    set -l config_file "$config_dir/current.toml"

    # Check for current.toml, fallback to default.toml if missing
    if not test -f "$config_file"
        set config_file "$config_dir/default.toml"
    end

    if test -f "$config_file"
        set -gx STARSHIP_CONFIG "$config_file"
    end

    # Silence timeout warnings
    set -gx STARSHIP_LOG error

    starship init fish | source
end
