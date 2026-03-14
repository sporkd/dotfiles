set +euo pipefail

cd "{{ .chezmoi.homeDir }}" || exit 1

local backup_dir="$PWD/.dotfilebackups"
local timestamp=$(date +%Y-%m-%d_%H-%M)
local backup_file="$backup_dir/dotfiles_$timestamp.tar.gz"

if [[ ! -d "$backup_dir" ]]; then
  mkdir -p "$backup_dir"
fi

# TODO: remove when chezmoi run_once bug fixed
# if [[ -f "$backup_dir/.keep" ]]; then
#   cd -
#   exit 0
# fi

# IGNORED: items SPARED from backup/delete
local ignored="
Applications
Library
Documents
Downloads
Desktop
$backup_dir
.chezmoiscripts
.config
{{- if true -}}
.config/mise
{{- end -}}
.local
.local/share
.local/state
.ssh
"

# FORCED: These override items in IGNORED
local forced="
.asdf
.asdfrc
.cargo
.gem
{{- if false -}}
.local/share/mise
.local/state/mise
{{- end -}}
.local/state/gh
.local/state/last_update_check
.local/share/man
.local/share/nvim
.local/state/nvim
.node_modules
.pkgx
.rustup
.rbenv
.rvmrc
.ruby-version
.ssh/config
.tool-versions
.viminfo
.vscode
.zlogin
.zshrc
Brewfile.lock.json
Gemfile.lock
"

local collapse_child_dirs=(".config/")

# Zsh splitting: ensures no empty strings/newlines in arrays
local forced=(${(f)"$(echo "${forced}" | sed '/^[[:space:]]*$/d')"})
local ignored=(${(f)"$(echo "${ignored}" | sed '/^[[:space:]]*$/d')"})
local managed=(${(f)"$(chezmoi managed --path-style relative 2>/dev/null)"})

local generated_forcelist=()
local final_list=()

# Build the generated forced-list and truncate
for item in "${managed[@]}"; do
  local collapsed=0
  for prefix in "${collapse_child_dirs[@]}"; do
    local base="${prefix%/}"
    # Check if item is the base (e.g. .config) or child (e.g. .config/zsh)
    if [[ "$item" == "$base" ]] || [[ "$item" == "$prefix"* ]]; then
      local parts=(${(s:/:)item})
      if [[ ${#parts} -ge 2 ]]; then
        generated_forcelist+=("${parts[1]}/${parts[2]}")
      fi
      collapsed=1
      break
    fi
  done
  [[ $collapsed -eq 0 ]] && generated_forcelist+=("$item")
done

# Deduplicate
generated_forcelist=(${(u)generated_forcelist[@]})

# Apply ignored filter
for item in "${generated_forcelist[@]}"; do
  local skip=0
  for b in "${ignored[@]}"; do
    # Robust check: Exact match OR item is inside the ignored directory
    if [[ "$item" == "$b" ]] || [[ "$item" == "$b/"* ]]; then
      skip=1
      break
    fi
  done
  [[ $skip -eq 0 ]] && final_list+=("$item")
done

# Merge manual forced (overwrites previous ignores)
final_list+=("${forced[@]}")

# Cleanup (de-dup and verify existence)
final_list=(${(u)final_list[@]})
local verified_list=()
for item in "${final_list[@]}"; do
  [[ -z "${item// /}" ]] && continue
  [[ -e "$item" ]] && verified_list+=("$item")
done

if [[ ${#verified_list} -eq 0 ]]; then
  _print_ok "No files found to backup"
  cd -
  exit 0
fi

_print_info "Cleaning up your home directory for a clean install."
_print_info "But first, the following ${#verified_list} items will be backed up to:"
_print_info "$backup_file"

echo
for item in "${verified_list[@]}"; do
  _print_item "$PWD/$item"
done

echo
_print_danger "The above files and directories will be overwritten!"
_print_danger "Choose ${BOLD}NO${RESET} to skip this step if you no longer"
_print_danger "need them."
echo
_prompt -p "Backup now? [Y|n] " -d "Y" response
if [[ $response =~ ^(y|yes|Y) ]]; then
  echo
  _print_running "Backing up shell aliases"
  alias -L > "$HOME/aliases.bak" 2>&1

  echo
  _print_info "📦 Creating archive: $backup_file"

  # Check if pv is installed, otherwise fall back to verbose tar
  if (( $+commands[pv] )); then
    local total_size=$(du -sk "${verified_list[@]}" | awk '{sum+=$1} END {print sum}')
    tar -cf - "${verified_list[@]}" | pv -s ${total_size}k | gzip > "$backup_file"
  else
    _print_notice "pv not found. Falling back to verbose mode..."
    # -v shows files as they are added to the archive
    tar -czvf "$backup_file" "${verified_list[@]}"
  fi

  if [[ $? -ne 0 || ! -f "$backup_file" ]]; then
    _print_error "Oops, something went wrong. Aborting"
    cd -
    exit 1
  fi

  _print_ok "Backup successful!"
  echo
  _print_notice "You can restore anytime by running"
  _print_cmd "cd ~"
  _print_cmd "tar xzvf $backup_file"
  echo
  _prompt -c -p "Got it!"
else
  _print_skipping "backup"
fi

# RVM Implode
if type rvm > /dev/null 2>&1; then
  echo
  _print_danger "RVM detected. It conflicts with other Rubies"
  _print_danger "Proceeding with 'rvm implode'..."
  # 'yes' pipes confirmation to rvm to prevent hanging
  yes | rvm implode
fi

echo
_print_info "Cleaning up home directory..."
for item in "${verified_list[@]}"; do
  _print_running "rm -rf $item"
  rm -rf "$item"
done

# Final Sweep
_print_info "Cleaning up empty system directories..."
find .config .local/share .local/state -type d -empty -delete 2>/dev/null

cd -

echo
_print_ok "✨ Success!"
