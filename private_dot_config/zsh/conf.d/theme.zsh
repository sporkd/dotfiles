# Set LS_COLORS
local config_dir="$XDG_CONFIG_HOME/lscolors"
local colors_file="$config_dir/current"

if [[ ! -f "$colors_file" ]]; then
  colors_file="$config_dir/default"
fi

# 3. Read and Export
if [[ -f "$colors_file" ]]; then
  export LS_COLORS="$(< "$colors_file")"
fi

