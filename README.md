[![Acronym CI](https://github.com/department-of-veterans-affairs/acronyms/actions/workflows/acronym-ci.yml/badge.svg)](https://github.com/department-of-veterans-affairs/acronyms/actions/workflows/acronym-ci.yml)
# Overview

This is a list of acronyms in VA today.

Among other things, this list powers a DSVA and Lighthouse [Slack bot](https://github.com/department-of-veterans-affairs/wtf-bot).

## Contributing

Create a pull request; if the ci passes you can merge it. The `@all-va` team should have write access.

When adding a definition, please add a concise blurb in the context column about how this term is relevant to our work. _You can wrap text in quotes to avoid punctuation breaking the CSV_.

## CI
Any changes to the acronyms file will trigger a CI job that will run lint on the acronyms file to check for errors.
Any other changes will trigger a scripts-CI job that will run unit tests on scripts in this repository used to cleanup the acronyms file.

## Clean up
The terms can be cleaned up for duplicates and sorted via the cleanup script.

Run it via `cd scripts && ./clean.sh`. An output.csv file will be generated that you can replace the acronyms.csv file with.

### csvlint
You can (optionally) install [csvlint](https://github.com/Data-Liberation-Front/csvlint.rb) to check the format of the acronyms file. It requires Ruby v3.2.2. You can install it with `make csvlint-install` and then run it with `make csvlint`

### Other cleanup scripts
* `make format-acronyms` to fix other issues with the acronyms file, such as moving any all-lower-case or all-upper-case definition strings to title case, and turning smart quotes (e.g. “”‘’) to regular quotes. It will output to stdout.
* `make dupe-acronyms` will output to stdout acronyms that have multiple definitions. It can be used to check for potential duplicates.
* `make dupe-definitions` will output to stdout definitions that are the same across different acronyms.
* `make spelling-check` will check the spelling of all of the words in the acronyms file and print out potential errors. You need to run `make spelling-tool-install` first.
