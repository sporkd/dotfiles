#! /usr/bin/env zsh


typeset -U fpath FPATH
fpath[1,0]="$HOME/.config/zfunctions"
autoload -Uz $fpath[1]/*(.:t)
