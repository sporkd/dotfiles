function ls --description 'Call lsd or gls fallback'
    if type -q lsd
        set -l config_dir "$XDG_CONFIG_HOME/lsd"
        set -l current_dir "$config_dir/current"

        if test -f "$current_dir/colors.yaml"
            # group-dirs [none, first, last]
            command lsd --group-dirs first --config-file "$current_dir" $argv
        else
            # Uses config_dir by default
            command lsd --group-dirs first $argv
        end
    else if type -q gls
        command gls --color=auto --group-directories-first $argv
    else
        command ls $argv
    end
end
