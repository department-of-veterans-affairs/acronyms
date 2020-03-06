#!/usr/bin/env bash
# Prints duplicate definitions from the acronyms file
# Note: This isn't fully correct because it doesn't handle quoted strings with commas correctly
awk -F , 'NR==FNR{a[$2]++; next} a[$2]>1' ../acronyms.csv ../acronyms.csv | sort -k 2
