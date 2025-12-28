#!/bin/bash
#######################################################
# copy files of container to volume if changed
# (c) 2025 cndrbrbr
# example: ./watch_copy.sh /path/to/source/file.txt /path/to/destination/
#######################################################
# Check arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_file> <destination_path_or_file>"
    exit 1
fi

SOURCE_FILE="$1"
DEST_PATH="$2"

# Validate source
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Source file does not exist: $SOURCE_FILE"
    exit 2
fi

# If destination is a directory, keep filename
if [ -d "$DEST_PATH" ]; then
    DEST_FILE="$DEST_PATH/$(basename "$SOURCE_FILE")"
else
    DEST_FILE="$DEST_PATH"
    mkdir -p "$(dirname "$DEST_FILE")"
fi

echo "Watching: $SOURCE_FILE"
echo "Copy to:  $DEST_FILE"
echo "-----------------------------------"

# Watch and copy on change
inotifywait -m -e modify -e close_write -e attrib "$SOURCE_FILE" |
while read -r path event file; do
    echo "Change detected ($event) → copying"
    cp -f "$SOURCE_FILE" "$DEST_FILE"
done
