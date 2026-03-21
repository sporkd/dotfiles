function vivid_to_lsd --argument theme
    if test -z "$theme"
        echo "Usage: vivid_to_lsd <vivid-theme-name>"
        return 1
    end

    set -l raw (vivid generate $theme)

    # Helper to get specific UI element colors (directory, permissions, etc.)
    # -g returns ONLY the capture group (the color code)
    function _get_col --inherit-variable raw
        set -l col (echo $raw | string match -rg "$argv[1]=([0-9;]+)")
        if test -n "$col[1]"
            echo $col[1]
        else
            echo 00 # Fallback to default
        end
    end

    echo "# Generated from vivid theme: $theme"
    echo "#"
    echo "user: "(_get_col "us")
    echo "group: "(_get_col "gr")
    echo "permission:"
    echo "  read: "(_get_col "rd")
    echo "  write: "(_get_col "wr")
    echo "  exec: "(_get_col "ex")
    echo "  no-access: "(_get_col "no")
    echo "file-type:"
    echo "  directory: "(_get_col "di")
    echo "  file:"
    echo "    exec: "(_get_col "ex")
    echo "    non-exec: "(_get_col "fi")
    echo "  symlink: "(_get_col "ln")
    echo "  pipe: "(_get_col "pi")
    echo "  socket: "(_get_col "so")
    echo "date: "(_get_col "da")
    echo "size:"
    echo "  none: "(_get_col "sn")
    echo "  small: "(_get_col "ss")
    echo "  medium: "(_get_col "sm")
    echo "  large: "(_get_col "sl")
    echo "inode: "(_get_col "in")
    echo "links:"
    echo "  valid: "(_get_col "ln")
    echo "  invalid: "(_get_col "or")
    echo "tree-edge: "(_get_col "di")

    echo "extension:"
    # This regex is more inclusive to handle extensions like .tar.gz or .c++
    # -rg captures only the extension name and the color code as separate list items
    set -l exts (echo $raw | string match -rg "\*\.([^=]+)=([0-9;]+)")

    set -l i 1
    while test $i -lt (count $exts)
        set -l ext_name $exts[$i]
        set -l ext_color $exts[(math $i + 1)]

        # We quote the extension name to prevent YAML parsing errors with weird chars
        echo "  \"$ext_name\": \"$ext_color\""

        set i (math $i + 2)
    end
    echo ""
end
