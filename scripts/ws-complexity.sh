#!/bin/sh
#
# Calculate whitespace complexity for a given file
#
# Prerequisites
# - The analysis must be executed from the analysis folder
# - The configuration file configuration.env must be sourced first
#
set -euf

FILE="$1"

cd "$REPOSITORY_PATH" || exit 1

if [ -z "$FILE" ] || [ ! -f "$FILE" ]; then
    echo "Cannot access file \"$FILE\"."
    echo
    echo "USAGE: ws-complexity.sh FILE"
    exit 1
fi

python3 "$MAAT_SCRIPTS/miner/complexity_analysis.py" "$FILE"

cd "$TARGET_DIR"
