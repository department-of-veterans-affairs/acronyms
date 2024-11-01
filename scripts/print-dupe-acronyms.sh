#!/usr/bin/env bash
# Prints out duplicate acronyms (first column matches)
poetry run csvsql --query \
"SELECT * FROM 'acronyms' WHERE Title IN (SELECT Title FROM 'acronyms' GROUP BY Title HAVING COUNT(Title) > 1) ORDER BY Title" \
../acronyms.csv
