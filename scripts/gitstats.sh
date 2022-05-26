#!/bin/sh
#
# Run GitStats analysis
#
# Prerequisites
# - The analysis must be executed from the analysis folder
# - The configuration file configuration.env must be sourced first
#
set -euf

# Cleanup
if [ -d "$TARGET_DIR/gitstats" ]; then
    rm -r "$TARGET_DIR/gitstats"
fi

# Generate HTML report
cd "$REPOSITORY_PATH" || exit 1
git checkout "$LAST_COMMIT_HASH"
python "$GITSTATS/gitstats" -c start_date="$FIRST_COMMIT_DATE" ./ "$TARGET_DIR/gitstats"
cd "$TARGET_DIR" || exit 0

# Print results
echo GitStats report has been generated. Open it as follows:
echo
echo "  open \"$TARGET_DIR/gitstats/index.html\""
