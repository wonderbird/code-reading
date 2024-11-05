## Analyze Hotspots: Find Hotspots of Effort and Complexity

```sh
# Go to your analysis folder containing the configuration.env file
# and read the configuration
cd "$HOME/Desktop/analysis"
source configuration.env

# Perform the hotspots analysis using Code Maat and maat-scripts
$CODE_READING/scripts/hotspots.sh
```

### Visualize Results

```sh
# Check which files have (not) been copied from the git changeset:
kdiff3 "$TARGET_DIR/hotspots/changeset_files.txt" "$TARGET_DIR/hotspots/copied_files.txt"

# Show the hotspots:
cat "$TARGET_DIR/hotspots/hotspots.csv"

# Run a python server on http://localhost:8888/ to view the hotspot visualization:
pushd "$TARGET_DIR/hotspots" && python3 -m http.server 8888 && popd
open "http://localhost:8888/hotspots.html"
```

### Note

The hotspot analysis does not exclude files which usually are changed frequently and are large, like

- package.json
- *.csproj files
- other build related files

Please take this into account when interpreting the results.

TODO Establish an "exclude file (pattern)" mechanism.
