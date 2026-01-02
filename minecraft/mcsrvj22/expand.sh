#!/bin/bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
    echo "Usage: $0 <input_dir> [output_dir]"
    exit 1
fi

INPUT_DIR="$1"
OUTPUT_DIR="$1"
#OUTPUT_DIR="${2:-$INPUT_DIR}"

if [[ ! -d "$INPUT_DIR" ]]; then
    echo "❌ Input directory does not exist: $INPUT_DIR"
    exit 1
fi

shopt -s nullglob

for file in "$INPUT_DIR"/*.tar "$INPUT_DIR"/*.tar.gz "$INPUT_DIR"/*.tgz "$INPUT_DIR"/*.zip; do
    echo "➡️  Entpacke: $(basename "$file")"

    case "$file" in
        *.tar)
            tar -xf "$file" -C "$OUTPUT_DIR"
            ;;
        *.tar.gz|*.tgz)
            tar -xzf "$file" -C "$OUTPUT_DIR"
            ;;
        *.zip)
            unzip -o "$file" -d "$OUTPUT_DIR"
            ;;
    esac
done

