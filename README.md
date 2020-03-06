# Overview

This is a list of acronyms in VA today.

Among other things, this list powers a DSVA and Lighthouse [Slack bot](https://github.com/department-of-veterans-affairs/wtf-bot).

## Contributing

Commits directly to `master` are welcome. If you would prefer a review, create a pull request and select [batemapf](https://github.com/batemapf) as a reviewer.

## Clean up
The terms can be cleaned up for duplicates and sorted via the cleanup script.

Run it via `./clean.sh`. An output.csv file will be generated that you can replace the acronyms.csv file with.

### csvlint
You can (optionally) install [csvlint](https://github.com/theodi/csvlint.rb) to check the format of the acronyms file. It requires Ruby v2.4.9 (later versions don't seem to work), and can be installed with `bundle`.

### Other cleanup scripts
* `check_acronyms.py` can be invoked to fix other issues with the acronyms file, such as moving any all-lower-case or all-upper-case definition strings to title case, and turning smart quotes (e.g. “”‘’) to regular quotes. It will output to stdout.
* `print-dupe-acronyms.sh` will output to stdout acronyms that have multiple definitions. It can be used to check for potential duplicates.
* `print-dupe-definitions.sh` will output to stdout definitions that are the same across different acronyms.
* `check-spelling.sh` will check the spelling of all of the words in the acronyms file and print out potential errors.
