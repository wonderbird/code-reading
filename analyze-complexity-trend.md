## Analyze Trend of Hotspot Complexity

```sh
# Go to your analysis folder containing the configuration.env file
# and read the configuration
cd "$HOME/Desktop/analysis"
source configuration.env

# For each hotspot, display how the complexity has changed over time
$CODE_READING/scripts/hotspot-complexity-trend.sh "hotspot file path relative to repository root, see hotspots.csv"
```
