{{ if eq .chezmoi.os "darwin" }}
# Make Apple Terminal behave
export SHELL_SESSIONS_DISABLE=${SHELL_SESSIONS_DISABLE:-1}
{{ end }}
