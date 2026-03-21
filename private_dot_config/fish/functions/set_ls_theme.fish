function set_ls_theme --argument theme
    if test -z "$theme"
        echo "Usage: set_ls_theme <vivid-theme-name>"
        return 1
    end

    set -l lscolors_dir "$XDG_CONFIG_HOME/lscolors"
    set -l lsd_dir "$XDG_CONFIG_HOME/lsd"
    set -l lsd_current_dir "$lsd_dir/current"

    if not test -f "$lsd_current_dir/config.yaml"
        mkdir -p "$lsd_current_dir"
        ln -sf "$lsd_dir/config.yaml" "$lsd_current_dir/config.yaml"
    end

    if type -q vivid
        set -l generated (vivid generate "$theme")
        echo "$generated" >"$lscolors_dir/current"

        vivid_to_lsd "$theme" >"$lsd_current_dir/colors.yaml"
        source "$XDG_CONFIG_HOME/fish/conf.d/theme.fish"

        echo "✔ Theme '$theme' activated"
    else
        echo "✘ Error: 'vivid' not found"
        return 1
    end
end
