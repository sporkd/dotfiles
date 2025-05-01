_prompt -p "Open a kitty terminal now? [Y|n] " -d "Y" resp
if [[ $resp =~ ^(y|yes|Y) ]]; then
  {{ if eq .chezmoi.os "darwin" }}
  open /Applications/kitty.app
  {{ else if eq .chezmoi.os "linux" }}
  # kitty -1 --hold & disown
  kitty --detach
  {{ end }}
fi
