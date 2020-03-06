#!/usr/bin/env bash

echo "Running spell check on acronyms.csv"
echo "Potentially misspelled words:"
# 1. Removes the first column of acronyms
# 2. Removes all acronyms in the remaining text (all uppercase+digits)
# 3. Lowercases all mixed-case words
# 4. Passes result to hunspell, including use of a custom VA dictionary
# 5. Sorts the output, removing duplicates
cut -d, -f2-4 acronyms.csv | \
gsed -E 's/\<[[:upper:]|[:digit:]]{2,}\>/ /g' | \
gsed -E 's/([[:upper:]]*[[:lower:]]+[[:upper:]]+[[:lower:]]*)+/\L&/g' | \
hunspell -d en_us,en_med_glut -p va.dic -l | \
sort -u -f
