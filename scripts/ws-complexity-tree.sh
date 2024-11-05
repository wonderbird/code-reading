#!/bin/sh
#
# Calculate whitespace complexity for a given directory tree
#
# Prerequisites
# - The analysis must be executed from the analysis folder
# - The configuration file configuration.env must be sourced first
#
set -euf

DIRECTORY="$1"

cd "$REPOSITORY_PATH" || exit 1

if [ -z "$DIRECTORY" ] || [ ! -d "$DIRECTORY" ]; then
    echo "Cannot access file \"$DIRECTORY\"."
    echo
    echo "USAGE: ws-complexity.sh DIRECTORY"
    exit 1
fi

FILE_LIST=$(find "$DIRECTORY" -type f)

cd "$TARGET_DIR"

NUMBER_OF_FILES=$(echo "$FILE_LIST" | wc -l)
printf "Analsing %d files " "$NUMBER_OF_FILES"

# Print CSV header
FIRST_FILE=$(echo "$FILE_LIST" | head -n 1)
printf "file," > "$TARGET_DIR/ws-complexity-tree.csv"
"$CODE_READING/scripts/ws-complexity.sh" "$FIRST_FILE" | head -n 1 >> "$TARGET_DIR/ws-complexity-tree.csv"

# Analyse the whitespace complexity for each file
for FILE in $FILE_LIST; do
    printf "."
    printf "%s," "$FILE" >> "$TARGET_DIR/ws-complexity-tree.csv"
    "$CODE_READING/scripts/ws-complexity.sh" "$FILE" | tail -n 1 >> "$TARGET_DIR/ws-complexity-tree.csv"
done

# Print summary
printf "\nResults saved in %s\n" "$TARGET_DIR/ws-complexity-tree.csv"
