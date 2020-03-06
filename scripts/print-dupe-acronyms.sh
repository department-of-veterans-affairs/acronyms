#!/usr/bin/env bash
# Prints out duplicate acronyms (first column matches)

awk -F , 'NR==FNR{a[$1]++; next} a[$1]>1' ../acronyms.csv ../acronyms.csv | sort
