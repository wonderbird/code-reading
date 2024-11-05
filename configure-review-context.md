## Configure the Review Context

To use the tools described in the following sections, you need to specify working data.

For this purpose,

1. create a folder for analysis files - I will call that "analysis folder" in the following,
2. create an empty text file named  `configuration.env` in that folder - I will call that "configuration file" in the
   following

Next, enter the following data into the configuration file:

```sh
# Save current directory as analysis target folder
export TARGET_DIR=$PWD

# Path to the checkout of this code reading repository
export CODE_READING=

# Path to your local gitstats checkout
export GITSTATS=

# Path to your local maat-scripts checkout
export MAAT_SCRIPTS=

# Path to the extracted Code Maat visualization
# Download from section "Download the samples" in https://adamtornhill.com/code/crimescenetools.htm
export MAAT_SAMPLE=

# Full path to the checked out repository
export REPOSITORY_PATH=

# Date format: YYYY-MM-DD
# You can find the first commit of interest by
# git log --pretty=format:'%ad,%an[%h]' --date=short --after=2023-08-01 | sort -rg
export DAY_BEFORE_FIRST_COMMIT_DATE=
export LAST_COMMIT_HASH=
export BASE_COMMIT_HASH=
```
