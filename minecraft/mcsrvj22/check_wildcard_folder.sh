#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------
# Usage:
#   check_wildcard_folder.sh <base_dir> <pattern>
#
# Example:
#   check_wildcard_folder.sh /root/mcsrvbase/data/worlds "world*"
# ----------------------------------------

BASE_DIR="${1:-}"
PATTERN="${2:-}"

# Parameter prüfen
if [[ -z "$BASE_DIR" || -z "$PATTERN" ]]; then
    exit 2
fi

# Basisverzeichnis vorhanden?
if [[ ! -d "$BASE_DIR" ]]; then
    exit 3
fi

shopt -s nullglob

matches=("$BASE_DIR"/$PATTERN)

# Nur Verzeichnisse zählen
count=0
for m in "${matches[@]}"; do
    [[ -d "$m" ]] && ((count++))
done

if (( count > 0 )); then
    exit 0   # ✔ mindestens ein Ordner gefunden
else
    exit 1   # ✖ kein Ordner gefunden
fi
