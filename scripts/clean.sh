#!/usr/bin/env bash

OUTPUTFILE=output.csv

sort -d -f ../acronyms.csv | uniq -i > ${OUTPUTFILE}
sed -i '' '/Title,/d' ${OUTPUTFILE}
sed -i '' '1i\
Title,Meaning,Context,Notes
' ${OUTPUTFILE}

# run csv lint if installed (https://github.com/theodi/csvlint.rb)
if [ -x "$(command -v csvlint)" ]; then
  echo "Running CSV lint on output.csv"
  csvlint ${OUTPUTFILE}
fi
