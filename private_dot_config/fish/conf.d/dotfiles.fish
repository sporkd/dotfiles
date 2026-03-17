#!/usr/bin/env fish

# Check dotfile repo for updates every 4 days
set fetch_head "{{ .chezmoi.sourceDir }}/.git/FETCH_HEAD"

# Get mtime: use the file if it exists, otherwise 0 (so it triggers a fetch).
# stat syntax differs between macOS (stat -f '%m') and Linux (stat -c '%Y').
set ts (stat -f '%m' $fetch_head 2>/dev/null; or stat -c '%Y' $fetch_head 2>/dev/null; or echo 0)

# Compute 4-day threshold in seconds portably — avoids `date -v` (macOS-only)
# and `date -d` (Linux-only) entirely.
set threshold (math (date +%s) - 345600)

if test $ts -lt $threshold
  # Only attempt fetch if the directory is actually a git repo
  if test -d "{{ .chezmoi.sourceDir }}/.git"
    git -C "{{ .chezmoi.sourceDir }}" fetch 2>/dev/null

    # Check status for "behind" message
    if git -C "{{ .chezmoi.sourceDir }}" status -sb 2>/dev/null | grep -q behind
      set cyan (tput setaf 6)
      set reset (tput sgr0)
      echo -e "\nNew dotfile updates available 😎! Run "(set_color cyan)chezmoi update(set_color normal)" to get them."
    end
  end
end
