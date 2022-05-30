#!/bin/sh
#
# Analyze hotspots of complexity and effort
#
# Prerequisites
# - The analysis must be executed from the analysis folder
# - The configuration file configuration.env must be sourced first
#
set -euf

HOTSPOT="$1"

cd "$REPOSITORY_PATH" || exit 1

if [ -z "$HOTSPOT" ] || [ ! -f "$HOTSPOT" ]; then
    echo "Cannot access hotspot file \"$HOTSPOT\"."
    echo
    echo "USAGE: hotspot-complexity-trend.sh HOTSPOT"
    exit 1
fi

python "$MAAT_SCRIPTS/miner/complexity_analysis.py" "$HOTSPOT"
python "$MAAT_SCRIPTS/miner/git_complexity_trend.py" --start "$BASE_COMMIT_HASH" --end "$LAST_COMMIT_HASH" --file "$HOTSPOT" > "$TARGET_DIR/hotspots/hotspot_trend.csv"
python "$MAAT_SCRIPTS/plot/plot.py" --column 2 --file "$TARGET_DIR/hotspots/hotspot_trend.csv"
python "$MAAT_SCRIPTS/plot/plot.py" --column 3 --file "$TARGET_DIR/hotspots/hotspot_trend.csv"
python "$MAAT_SCRIPTS/plot/plot.py" --column 4 --file "$TARGET_DIR/hotspots/hotspot_trend.csv"

cd "$TARGET_DIR"
