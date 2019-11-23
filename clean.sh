#!/usr/bin/env bash

sort -d -f acronyms.csv | uniq -i > output.csv
sed -i '' '/Title,/d' output.csv
sed -i '' '1i\
Title,Meaning,Context,Notes
' output.csv

# run csv lint if installed (https://github.com/theodi/csvlint.rb)
if [ -x "$(command -v csvlint)" ]; then
  csvlint output.csv
fi
