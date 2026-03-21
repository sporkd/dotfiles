# Set LS_COLORS
set -l config_dir "$XDG_CONFIG_HOME/lscolors"
set -l colors_file "$config_dir/current"

if not test -f "$colors_file"
    set colors_file "$config_dir/default"
end

if test -f "$colors_file"
    set -gx LS_COLORS (cat "$colors_file")
end

# Set fish_config theme
if set -q FISH_THEME
    fish_config theme choose "$FISH_THEME"
end
