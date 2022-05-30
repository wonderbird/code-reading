#!/usr/bin/env awk
#
# Convert the output from CPD to a CSV file.
#
# Each line in the CSV corresponds to one block of duplicated code
# The first column "number_of_lines" represents the size of the duplicated code
# block, the second column "number_of_places" tells how many copies exist.
#
# Sample:
#
# number_of_lines, number_of_places
# 65, 3
#
# represents one code block with 65 lines, which can be found at 3 code places.
#
BEGIN {
    is_new_chunk = 0;
    files_in_chunk = -1; duplicate_lines = 0; print "number_of_lines,number_of_places"
}

/^Found a/ { is_new_chunk = 1; duplicate_lines = $3 }
/^.+$/ { if (is_new_chunk == 1) files_in_chunk++ }
/^$/ { if (is_new_chunk) print duplicate_lines "," files_in_chunk; is_new_chunk = 0; files_in_chunk = -1; duplicate_lines = 0 }
