#!/usr/bin/env bash

set -eu

OUTPUTFILE=output.csv

sort -d -f ../acronyms.csv | uniq -i > ${OUTPUTFILE}

# delete csv header row.
grep -v '^Title\,Meaning\,Context\,Notes' ${OUTPUTFILE} > temp && mv temp ${OUTPUTFILE}

# add back header row
echo 'Title,Meaning,Context,Notes' | cat - ${OUTPUTFILE} > temp && mv temp ${OUTPUTFILE}

# run csv lint if installed (https://github.com/theodi/csvlint.rb)
if [ -x "$(command -v csvlint)" ]; then
  echo "Running CSV lint on output.csv"
  csvlint ${OUTPUTFILE}
fi
