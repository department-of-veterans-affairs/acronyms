#!/usr/bin/env bash

sort -u acronyms.csv | uniq -i > output.csv
sed -i '/Title,/d' output.csv
sed -i '1iTitle, Meaning, Context, Notes' output.csv