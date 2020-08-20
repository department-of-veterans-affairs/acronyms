#!/usr/bin/env bash

set -eu

OUTPUTFILE=output.csv

sort -d -f ../acronyms.csv | uniq -i > ${OUTPUTFILE}

# delete csv header row.
grep -v '^acronym\,definition\,context\,notes' ${OUTPUTFILE} > temp && mv temp ${OUTPUTFILE}

# add back header row
echo 'acronym,definition,context,notes' | cat - ${OUTPUTFILE} > temp && mv temp ${OUTPUTFILE}

# run csv lint if installed (https://github.com/theodi/csvlint.rb)
if [ -x "$(command -v csvlint)" ]; then
  echo "Running CSV lint on output.csv"
  csvlint ${OUTPUTFILE}
fi
