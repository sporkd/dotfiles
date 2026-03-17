# Aliases

# vim
if (( $+commands[nvim] )); then
  alias vi=nvim
  alias vim=nvim
  alias tree='et'
fi

# lsd
if (( $+commands[lsd] )); then
  alias ls="lsd -g"
  alias ll="lsd -lg"
  alias la="lsd -ag"
  alias lt="lsd -g --tree"
  alias lh="lsd -dg .*"  # list only hidden files
fi

# other
alias diff="diff --color=always --suppress-common-lines"
alias ranger="VISUAL=$EDITOR ranger"
alias icat='kitty +kitten icat'
alias uuid="uuidgen | tr -d '\\n' | tr '[:upper:]' '[:lower:]' | pbcopy; pbpaste; echo"
alias weather='curl wttr.in'
alias genpass='dd if=/dev/urandom bs=1 count=18 2>/dev/null | base64 | rev | cut -b 2- | rev'
