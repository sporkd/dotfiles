#! /usr/bin/env fish

# secrets
# source ~/.config/fish/secrets.fish

if status --is-interactive
  # allow git to prompt for passphrase (when expires)
  # export GPG_TTY=$(tty)

  # no need for a greeting
  set fish_greeting

  # source variables
  source ~/.config/fish/variables.fish

  # source git abbreviations
  source ~/.config/fish/abbr.fish

  # init tea
  test -d "$HOME/.tea" && "$HOME/.tea/tea.xyz/v*/bin/tea" --magic=fish --silent | source

  # kitty completions
  # kitty + complete setup fish | source

  set -x TIME_STYLE long-iso

  set -x MANPAGER "nvim +Man!"

  # https://www.pgcli.com/pager
  set -x LESS "-XFR"

  set -x RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/ripgreprc"
  set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!doc/*"'

  set -gx GOPATH $HOME/go
  set -gx fish_user_paths $GOPATH/bin $fish_user_paths

  switch (uname)
  case Darwin
    fish_add_path "/usr/local/bin"
    fish_add_path "$HOME/bin"
    fish_add_path "$HOME/.local/bin"
    fish_add_path "$HOME/.tea/.local/bin" # TODO remove once this PR is merged https://github.com/teaxyz/cli/pull/657

    if test -e /opt/homebrew/bin/brew
      eval (/opt/homebrew/bin/brew shellenv)
    else if test -e /usr/local/bin/brew
      eval (/usr/local/bin/brew shellenv)
    end

    # rust/cargo
    fish_add_path "$HOME/.cargo/bin"
  case Linux
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.gem/bin
    fish_add_path $HOME/bin
    fish_add_path $HOME/.node_modules/bin \

    # globally install node modules in $HOME directory
    set -x NPM_CONFIG_PREFIX $HOME/.node_modules
    set -x GEM_HOME $HOME/.gem/
  end

  # zoxide init fish | source
  starship init fish | source
end
