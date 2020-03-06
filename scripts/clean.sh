#!/usr/bin/env bash

OUTPUTFILE=output.csv

sort -d -f ../acronyms.csv | uniq -i > ${OUTPUTFILE}

# delete csv header row.
grep -v '^Title\,Meaning\,Context\,Notes' acronyms.csv > output.csv

# add back header row
echo 'Title,Meaning,Context,Notes' | cat - output.csv > temp && mv temp output.csv

# run csv lint if installed (https://github.com/theodi/csvlint.rb)
if [ -x "$(command -v csvlint)" ]; then
  echo "Running CSV lint on output.csv"
  csvlint ${OUTPUTFILE}
fi
