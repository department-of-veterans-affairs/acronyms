# Overview

This is a list of acronyms in VA today.

Among other things, this list powers a DSVA and Lighthouse [Slack bot](https://github.com/department-of-veterans-affairs/wtf-bot).

## Contributing

Commits directly to `master` are welcome. If you would prefer a review, create a pull request and select [batemapf](https://github.com/batemapf) as a reviewer.

## CI
Any changes to the acronyms file will trigger a CI job that will run lint on the acronyms file to check for errors.
Any other changes will trigger a scripts-CI job that will run unit tests on scripts in this repository used to cleanup the acronyms file.

## Clean up
The terms can be cleaned up for duplicates and sorted via the cleanup script.

Run it via `cd scripts && ./clean.sh`. An output.csv file will be generated that you can replace the acronyms.csv file with.

### csvlint
You can (optionally) install [csvlint](https://github.com/theodi/csvlint.rb) to check the format of the acronyms file. It requires Ruby v2.7.6 (later versions don't seem to work). You can install it with `make csvlint-install` and then run it with `make csvlint`

### Other cleanup scripts
* `make format-acronyms` to fix other issues with the acronyms file, such as moving any all-lower-case or all-upper-case definition strings to title case, and turning smart quotes (e.g. “”‘’) to regular quotes. It will output to stdout.
* `make dupe-acronyms` will output to stdout acronyms that have multiple definitions. It can be used to check for potential duplicates.
* `make dupe-definitions` will output to stdout definitions that are the same across different acronyms.
* `make spelling-check` will check the spelling of all of the words in the acronyms file and print out potential errors. You need to run `make spelling-tool-install` first.
