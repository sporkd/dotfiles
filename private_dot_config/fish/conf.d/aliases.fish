# Aliases for commands that can't be abbreviations due to pipes or subshells.
# Simple substitutions live in abbr.fish instead.

# Use Neovim as the primary vim
if type -q nvim
    alias vi='nvim'
    alias vim='nvim'
end

alias diff "diff --color=always --suppress-common-lines"
alias uuid "uuidgen | tr -d '\\n' | tr '[:upper:]' '[:lower:]' | pbcopy; pbpaste; echo"
alias genpass "dd if=/dev/urandom bs=1 count=18 2>/dev/null | base64 | rev | cut -b 2- | rev"
