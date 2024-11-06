## Identify Examples of Complex Code

```sh
# Go to your analysis folder containing the configuration.env file
# and read the configuration
cd "$HOME/Desktop/analysis"
source configuration.env

# Create CSV file containing white space complexity metrics per file
# in directory tree
$CODE_READING/scripts/ws-complexity-tree.sh "directory relative to repository root"
```

Then load the CSV file into a spreadsheet application and sort as follows:

1. total, descending
2. n, ascending

The files with highest accumulated indentation complexity (whitespace complexity, ws-complexity) will be on top.

Note that this way of looking at the code **ignores the business value of fixing the complexity** issues. However, it may be helpful when searching for examples of complex code as a basis for a discussion or training.

### References

- Section Whitespace Analysis of Complexity in [Adam Tornhill: Your Code as a Crime Scene](https://pragprog.com/titles/atcrime2/your-code-as-a-crime-scene-second-edition/)
- [Abram Hindle, et al.: Reading Beside the Lines: Indentation as a Proxy for Complexity Metric](https://doi.org/10.1109/ICPC.2008.13)
