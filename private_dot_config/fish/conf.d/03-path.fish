# Prepend paths in the specific order requested
# fish_add_path -p prepends to the front of the list
fish_add_path -p /usr/local/bin
fish_add_path -p $HOME/.local/bin
fish_add_path -p $HOME/bin

# Append standard manpaths
for p in $__fish_data_dir/man /usr/local/share/man /usr/share/man
    if test -d $p
        contains $p $MANPATH; or set -gx MANPATH $MANPATH $p
    end
end
