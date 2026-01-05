#!/usr/bin/env bash
set -euo pipefail

# -----------------------------
# Usage:
#   ./check_wildcard_file.sh "/pfad/zum/ordner" "muster*.*"
# Example:
#   ./check_wildcard_file.sh /root/mcsrvbase/data/plugins "dynmap*.jar"
# -----------------------------

DIR="${1:-}"
PATTERN="${2:-}"

if [[ -z "$DIR" || -z "$PATTERN" ]]; then
    echo "Usage: $0 <directory> <wildcard-pattern>"
    exit 2
fi

if [[ ! -d "$DIR" ]]; then
    echo "ERROR: Verzeichnis existiert nicht: $DIR"
    exit 3
fi

shopt -s nullglob

matches=("$DIR"/$PATTERN)

if (( ${#matches[@]} > 0 )); then
    echo "✔ Datei(en) gefunden:"
    for f in "${matches[@]}"; do
        echo "  - $(basename "$f")"
    done
    exit 0
else
    echo "✖ Keine Datei gefunden für Muster: $PATTERN"
    exit 1
fi
