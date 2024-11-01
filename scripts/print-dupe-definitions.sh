#!/usr/bin/env bash
# Prints duplicate definitions from the acronyms file
poetry run csvsql --query \
"SELECT * FROM 'acronyms' WHERE Meaning IN (SELECT Meaning FROM 'acronyms' GROUP BY Meaning HAVING COUNT(Meaning) > 1) ORDER BY Meaning" \
../acronyms.csv
