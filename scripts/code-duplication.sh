#!/usr/bin/env bash
#
# Identify copied code blocks
#
# Parameters
#
# $1    Abbreviation of the programming language used. See "language" parameter
#       for CPD - https://pmd.github.io/latest/pmd_userdocs_cpd.html#supported-languages
#
# Prerequisites
# - The analysis must be executed from the analysis folder
# - The configuration file configuration.env must be sourced first
#
set -euf

# rm -r "$TARGET_DIR/$SUFFIX/db/IPPS/Migrations"
# rm -r "$TARGET_DIR/$SUFFIX/db_unittests/scripts/sql/33000_test_test_files"

PROGRAMMING_LANGUAGE="$1"
if [ -z "$PROGRAMMING_LANGUAGE" ]; then
    echo "USAGE: code-duplication.sh LANGUAGE"
    exit 1
fi

mkdir -p "$TARGET_DIR/code_duplication"

# Find Code Dupliation
pmd cpd \
    --minimum-tokens 100 \
    --files "$TARGET_DIR/hotspots/latest" \
    --language "$PROGRAMMING_LANGUAGE" \
  > "$TARGET_DIR/code_duplication/$PROGRAMMING_LANGUAGE.txt"
