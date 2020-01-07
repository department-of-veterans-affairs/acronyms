#!/usr/bin/env bash

# remove dups (ignores case)
sort -d -f acronyms.csv | uniq -i > output.csv

# delete csv header row.
grep -v '^Title\,Meaning\,Context\,Notes' acronyms.csv > output.csv

# add back header row
echo 'Title,Meaning,Context,Notes' | cat - output.csv > temp && mv temp output.csv

# run csv lint if installed (https://github.com/theodi/csvlint.rb)
if [ -x "$(command -v csvlint)" ]; then
  csvlint output.csv
fi
