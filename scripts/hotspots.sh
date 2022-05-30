#!/usr/bin/env bash
set -euf

function copy_files_to() {
    LIST_OF_FILES_PATH="$1"
    DESTINATION_DIR="$2"

    if [ -z "$LIST_OF_FILES_PATH" ] || [ ! -f "$LIST_OF_FILES_PATH" ]; then
        echo "ERROR: Cannot read list of files in '$LIST_OF_FILES_PATH'."
        return
    fi

    if [ -z "$DESTINATION_DIR" ]; then
        echo "ERROR: Target directory path must be provided."
        return
    fi
    if [ -d "$DESTINATION_DIR" ]; then
        rm -vr "$DESTINATION_DIR"
    fi

    while IFS= read -r FILE; do
        if [ -f "$FILE" ]; then
           SUBDIR=$(dirname "$FILE")
           mkdir -p "$DESTINATION_DIR/$SUBDIR" && cp "$FILE" "$DESTINATION_DIR/$SUBDIR"
        fi
    done < "$LIST_OF_FILES_PATH"
}

# Cleanup
if [ -d "$TARGET_DIR/hotspots" ]; then
    rm -r "$TARGET_DIR/hotspots"
fi
mkdir -p "$TARGET_DIR/hotspots"

cd "$REPOSITORY_PATH" || exit 1

# Copy the latest versions of the changed files into a separate folder
echo "Copy latest versions of changed files to analysis folder ..."
git checkout "$LAST_COMMIT_HASH"
git diff --name-only "$BASE_COMMIT_HASH" "$LAST_COMMIT_HASH" | sort -g > "$TARGET_DIR/hotspots/changeset_files.txt"
copy_files_to "$TARGET_DIR/hotspots/changeset_files.txt" "$TARGET_DIR/hotspots/latest"

# Verify that all files have been copied
cd "$TARGET_DIR/hotspots/latest" || exit 1
find . -type f | sort -g > "$TARGET_DIR/hotspots/copied_files.txt"
sed -i '' 's/^\.\///' "$TARGET_DIR/hotspots/copied_files.txt";

# Calculate Lines of Code per file as a complexity proxy metric
echo "Analyze LoC per changed file ..."
docker run -v "$PWD:/data" --rm --name cloc cloc-app /data --by-file --csv --quiet "--report-file=/data/lines.csv"
mv "lines.csv" "$TARGET_DIR/hotspots"
sed -i '' 's/\/data\///' "$TARGET_DIR/hotspots/lines.csv"

# Export git history for code maat
echo "Export git history ..."
cd "$REPOSITORY_PATH" || exit 1
git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat --after="$DAY_BEFORE_FIRST_COMMIT_DATE" > "$TARGET_DIR/hotspots/evo.log";

# Run Code Maat to find the change frequencies in the exported git history
echo "Analyze change frequency per changed file ..."
docker run -v "$TARGET_DIR/hotspots":/data -it code-maat-app -l "/data/evo.log" -c git -a revisions > "$TARGET_DIR/hotspots/freqs.csv"

# Combine LoC and change frequencies to identify hotspots
echo "Generate hotpots.csv ..."; \
python "$MAAT_SCRIPTS/merge/merge_comp_freqs.py" "$TARGET_DIR/hotspots/freqs.csv" "$TARGET_DIR/hotspots/lines.csv" > "$TARGET_DIR/hotspots/hotspots.csv"

echo "Generate Hotspot Visualization (HTML + D3) ..."
python "$MAAT_SCRIPTS/transform/csv_as_enclosure_json.py" --structure "$TARGET_DIR/hotspots/lines.csv" --weights "$TARGET_DIR/hotspots/freqs.csv" --weightcolumn 1 > "$TARGET_DIR/hotspots/hotspot_proto.json"
mkdir "$TARGET_DIR/hotspots/d3"
cp "$MAAT_SAMPLE/hibernate/d3/d3.min.js" "$MAAT_SAMPLE/hibernate/d3/LICENSE" "$TARGET_DIR/hotspots/d3/"
cp "$MAAT_SAMPLE/hibernate/hibzoomable.html" "$TARGET_DIR/hotspots/hotspots.html"
sed -i '' "s/hib_hotspot_proto/hotspot_proto/g" "$TARGET_DIR/hotspots/hotspots.html"

# Print a summary

echo
echo "The following commands let you review the results:"
echo "=================================================="
echo
echo "Check which files have (not) been copied from the git changeset:"
echo "    kdiff3 \"$TARGET_DIR/hotspots/changeset_files.txt\" \"$TARGET_DIR/hotspots/copied_files.txt\""
echo
echo "Show the hotspots:"
echo "    cat \"$TARGET_DIR/hotspots/hotspots.csv\""
echo
echo "Run a python server on http://localhost:8888/ to view the hotspot visualization:"
echo "    pushd \"$TARGET_DIR/hotspots\" && python -m http.server 8888 && popd"
echo "    Then open http://localhost:8888/hotspots.html"
echo

cd "$TARGET_DIR" || exit 0
