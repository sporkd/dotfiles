(( $+functions[history-substring-search-up] )) || return 1

# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

# Emacs
# bindkey -M emacs '^P' history-substring-search-up
# bindkey -M emacs '^N' history-substring-search-down

# Vi
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

# Emacs and Vi
# for _keymap in 'main' 'emacs' 'viins'; do
for _keymap in 'main' 'viins'; do
  bindkey -M "$_keymap" "$terminfo[kcuu1]" history-substring-search-up
  bindkey -M "$_keymap" "$terminfo[kcud1]" history-substring-search-down
done

unset _keymap
