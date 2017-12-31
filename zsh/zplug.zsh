# Return if zplug is not loaded
[[ -v ZPLUG_HOME ]] || return

# Manage zplug as a plugin when you zplug update
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Plugins
# zplug "arzzen/calc.plugin.zsh"
# zplug "rimraf/k"
# zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

# Themes
zplug "denysdovhan/spaceship-zsh-theme", use:spaceship.zsh, from:github, as:theme

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load # --verbose
