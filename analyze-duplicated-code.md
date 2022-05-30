## Analyze Duplicated Code: Run the Copy-Paste Detector (CPD) to Find Code Duplication

```sh
# Go to your analysis folder containing the configuration.env file
# and read the configuration
cd "$HOME/Desktop/analysis"
source configuration.env

# Perform the hotspots analysis using Code Maat and maat-scripts
#
# The programming language is stored in the environment variable "PROGRAMMING_LANGUAGE"
# so that it can be re-used below.
#
# Valid values of this "language" parameter are described on the
# CPD homepage: https://pmd.github.io/latest/pmd_userdocs_cpd.html#supported-languages
#
# Examples:
# "cs"      C#
# "java"    Java
# "pas"     Pascal
# "plsql"   PL/SQL
#
export PROGRAMMING_LANGUAGE=plsql
$CODE_READING/scripts/code-duplication.sh "$PROGRAMMING_LANGUAGE"
```

If you want to do some statistics with the duplicated code blocks, then the following
[awk](https://www.gnu.org/software/gawk/manual/gawk.html) script might be useful:

```sh
# Convert the report file to csv
awk -f "$CODE_READING/scripts/convert-cpd-report-to-csv.awk" "$TARGET_DIR/code_duplication/$PROGRAMMING_LANGUAGE.txt" > "$TARGET_DIR/code_duplication/$PROGRAMMING_LANGUAGE.csv"
```
