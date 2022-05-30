## Prerequisites

For the analyses described in this repository are run on macOS >= 12.4 (Monterey). You need the following tools:

### Python3

The tools listed below require [Python version 3](https://www.python.org/).

### GitStats

[gitstats](https://github.com/gktrk/gitstats) is a statistics generator for git repositories.

```sh
# gitstats requires gnuplot and python
brew install gnuplot

# clone gitstats and export its path to an environment variable
git clone https://github.com/gktrk/gitstats.git
```

### Hotspots

#### cloc

[cloc](https://github.com/AlDanial/cloc) counts blank lines, comment lines, and physical lines of source code in many
programming languages. Hotspot complexity is calculated quickly by counting the number of lines in a source code file.
Usually this measure correlates well with cyclomatic complexity (see section "Get Complexity by Lines of Code" in [Adam
Tornhill: Your Code as a Crime Scene](https://pragprog.com/titles/atcrime/your-code-as-a-crime-scene/)).

Because I use the [X++ modification of cloc](https://github.com/AlDanial/cloc/pull/634), this repository uses the latest
cloc version in a docker container:

```sh
git clone https://github.com/AlDanial/cloc.git
cd cloc
docker build -f Dockerfile --tag cloc-app .
```

#### Code Maat

[Code Maat](https://github.com/adamtornhill/code-maat) is used to mine and analyze data from version-control systems (VCS).

```sh
git clone https://github.com/adamtornhill/code-maat.git
cd code-maat

# Attention:
# If you are building the docker container on an M1 mac (Apple Silicon chip), then you need to replace the
#   FROM clojure:alpine
# line in the Dockerfile by
#   FROM clojure:latest

docker build -f Dockerfile --tag code-maat-app .
```

#### maat-scripts

[maat-scripts](https://github.com/adamtornhill/maat-scripts) are used to post-process the results from Code Maat.

```sh
git clone https://github.com/adamtornhill/maat-scripts.git
cd maat-scripts
git checkout python3

# Install dependencies
python -m pip install -r requirements.txt
```

#### Code Maat Sample Visualizations

Download and extract the pre-generated visualizations from section "Download the samples" of the site [Code as a Crime
Scene: The Tools](https://adamtornhill.com/code/crimescenetools.htm).

The extracted folder will configured as the `MAAT_SAMPLE` environment variable in the `configuration.env` file later.

#### CPD

The Copy Paste Detector from the [PMD Source Code Analyzer](https://pmd.github.io) project can be installed via [homebrew](https://brew.sh):

```sh
brew install pmd
```
