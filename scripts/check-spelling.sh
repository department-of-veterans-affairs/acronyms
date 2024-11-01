#!/usr/bin/env bash

set -e

echo "Running spell check on acronyms.csv"
echo "Misspelled words:"
# 1. Removes the first column of acronyms
# 2. Removes all acronyms in the remaining text (all uppercase+digits)
# 3. Lowercases all mixed-case words
# 4. Passes result to hunspell, including use of a custom VA dictionary
cut -d, -f2-4 ../acronyms.csv | \
gsed -E 's/\<[[:upper:]|[:digit:]]{2,}\>/ /g' | \
gsed -E 's/([[:upper:]]*[[:lower:]]+[[:upper:]]+[[:lower:]]*)+/\L&/g' | \
hunspell -d en_US,en_med_glut -p va.dic -l
# use this line instead to get full lines with misspelled words
# hunspell -d en_US,en_med_glut -p va.dic -l
