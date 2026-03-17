# Abbreviations expand in-place before execution, so history shows the full command.
# Complex aliases (pipes, subshells) live in aliases.fish instead.

# nvim
if command -q nvim
  abbr --add vi   nvim
  abbr --add vim  nvim
  abbr --add tree et
end

# lsd
if command -q lsd
  abbr --add ls "lsd -g"
  abbr --add ll "lsd -lg"
  abbr --add la "lsd -ag"
  abbr --add lt "lsd -g --tree"
  abbr --add lh "lsd -dg .*"
end

# other
abbr --add icat    "kitty +kitten icat"
abbr --add weather "curl wttr.in"
abbr --add ranger  "VISUAL=$EDITOR ranger"
