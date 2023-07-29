set -x EDITOR nvim
set -x VISUAL zed --wait
set -x GIT_EDITOR nvim

# disable homebrew github api https://github.com/Homebrew/brew/issues/93
set -x HOMEBREW_NO_GITHUB_API 1

# better pager in pgcli https://www.pgcli.com/pager
set -x LESS -XFR
