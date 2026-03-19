# Starship
if command -q starship
    if test -f $XDG_CONFIG_HOME/hooks/starship.toml
        # hook to override default ~/.config/starship.toml
        set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/hooks/starship.toml
    end
    set -gx STARSHIP_LOG error # silence timeout warnings
    starship init fish | source
end

fish_set_cursor blink_bar
