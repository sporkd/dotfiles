function unset_ls_theme
    rm -rf "$XDG_CONFIG_HOME/lscolors/current"
    rm -rf "$XDG_CONFIG_HOME/lsd/current"

    source "$XDG_CONFIG_HOME/fish/conf.d/theme.fish"

    echo "✔ Theme unset"
end
