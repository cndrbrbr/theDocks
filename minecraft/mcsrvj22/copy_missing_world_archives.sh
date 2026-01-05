#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./copy_missing_world_archives.sh "user@host" "/remote/worlds" "/local/worlds" [ssh_port] [identity_file]
#
# Example:
#   ./copy_missing_world_archives.sh "user1@192.168.115.135" "/mcsoftware/server/ehle25/worlds" "/root/mcsrvbase/data/worlds" 2222 /keys/cloud_key

REMOTE_HOST="${1:-}"
REMOTE_DIR="${2:-}"
LOCAL_DIR="${3:-}"
SSH_PORT="${4:-22}"
IDENTITY_FILE="${5:-}"

if [[ -z "$REMOTE_HOST" || -z "$REMOTE_DIR" || -z "$LOCAL_DIR" ]]; then
  echo "Usage: $0 <user@host> <remote_dir> <local_dir> [ssh_port] [identity_file]" >&2
  exit 2
fi

mkdir -p "$LOCAL_DIR"

SSH_OPTS=(-p "$SSH_PORT" -o StrictHostKeyChecking=no)
SCP_OPTS=(-P "$SSH_PORT" -o StrictHostKeyChecking=no)

if [[ -n "$IDENTITY_FILE" ]]; then
  SSH_OPTS+=(-i "$IDENTITY_FILE")
  SCP_OPTS+=(-i "$IDENTITY_FILE")
fi

# Remote: nur Archive listen (falls keine da sind -> leer)
REMOTE_FILES="$(
  ssh "${SSH_OPTS[@]}" "$REMOTE_HOST" \
    "ls -1 ${REMOTE_DIR} 2>/dev/null | grep -E '\.(zip|tar|tgz|tar\.gz)$' || true"
)"

if [[ -z "$REMOTE_FILES" ]]; then
  echo "Keine Archive gefunden in: $REMOTE_HOST:$REMOTE_DIR"
  exit 0
fi

# Helfer: "world.tar.gz" -> "world"
base_world_name() {
  local f="$1"
  f="${f##*/}"
  f="${f%.tar.gz}"
  f="${f%.tgz}"
  f="${f%.tar}"
  f="${f%.zip}"
  printf '%s' "$f"
}

copied=0
skipped=0

while IFS= read -r fname; do
  [[ -n "$fname" ]] || continue

  src="${REMOTE_DIR%/}/$fname"
  local_archive="$LOCAL_DIR/${fname##*/}"
  world_base="$(base_world_name "$fname")"
  local_world_dir="$LOCAL_DIR/$world_base"

  # Skip, wenn Archive schon lokal da ist
  if [[ -f "$local_archive" ]]; then
    echo "SKIP (Archive schon da): $local_archive"
    ((skipped++))
    continue
  fi

  # Skip, wenn World-Ordner schon entpackt da ist
  if [[ -d "$local_world_dir" ]]; then
    echo "SKIP (World schon entpackt): $local_world_dir"
    ((skipped++))
    continue
  fi

  echo "COPY: $REMOTE_HOST:$src  ->  $LOCAL_DIR/"
  scp "${SCP_OPTS[@]}" "$REMOTE_HOST:$src" "$LOCAL_DIR/"
  ((copied++))
done <<< "$REMOTE_FILES"

echo "Fertig. Kopiert: $copied | Übersprungen: $skipped"
