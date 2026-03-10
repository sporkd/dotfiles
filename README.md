# Dotfiles

Maintained with <https://chezmoi.io>

## Prerequisites on OS X

1. OS X `command-line-tools` installed (or a full `XCode` installation)
2. `git` installed and a GitHub account.

> [!TIP]
> Opening a terminal and running `git -v` should walk you through the
> process of installing xcode command line tools (if not already installed).
> Otherwise run `xcode-select --install`.

<br>

# Installation

### 1. Install `chezmoi` and boostrap your machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
~/.local/bin/chezmoi init --apply sporkd
```

Alternativley, you can install `chezmoi` to `/usr/local/bin`

```sh
sudo sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
/usr/local/bin/chezmoi init --apply sporkd
```

> [!NOTE]
> If something goes wrong during the installation, simply re-run the same `chezmoi init --apply` command.

### 2. Follow the prompts
Chezmoi will prompt you for a few things, like your email address for git commits and your preferred text editor (`VSCode`, `Neovim`, etc.). It will then walk you through all the installation steps and use those saved configs to setup everything customized for you.

### 3. That's it! :sparkles:
When you're finished, all you have to do is open a new `kitty` terminal and your new .zshrc will be loaded with your settings. :cat:

<br>

> [!IMPORTANT]
> If on chezmoi's first run, the installation detects that you have files in your home directory that would be overwritten,
> you will be prompted to back them up to your `~/.dotfilebackups` directory. That way you can always restore specific files,
> or go all the way back to the way things were.
