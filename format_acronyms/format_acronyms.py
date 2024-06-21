#!/usr/bin/env python3
"""
Script to fix various formatting issues with acronyms file
Does a few things, including:
1) Moving any all-lower-case definitions to Title case
2) Moving any all-upper-case strings in definitions to Title case
3) Turning smart quotes (e.g. “”‘’) to regular quotes
"""

import argparse
import csv
import sys


def fix_all_lower(row: list) -> list:
    if row[1].islower():
        row[1] = row[1].title()
    return row


def fix_all_upper(row: list) -> list:
    if row[1].isupper():
        row[1] = row[1].title()
    return row


# borrowed from https://stackoverflow.com/questions/40330953/dict-to-remove-smart-quotes
def fix_smart_quotes(row: list) -> list:
    charmap = {
        0x201C: '"',  # double left
        0x201D: '"',  # double right
        0x2018: "'",  # single left
        0x2019: "'",  # single right
    }

    for i, elem in enumerate(row):
        row[i] = elem.translate(charmap)

    return row


def process_row(row: list) -> list:
    row = fix_all_lower(row)
    row = fix_all_upper(row)
    row = fix_smart_quotes(row)
    return row


def main():
    parser = argparse.ArgumentParser(description="Fixes and outputs to stdout various issues with " + "acronyms file.")
    parser.add_argument(
        "-f",
        "--file",
        required=False,
        action="store",
        default="acronyms.csv",
        help="File to use. Default: acronyms.csv",
    )
    args = parser.parse_args()
    csv.register_dialect("my_format", lineterminator="\n", strict=True)
    csv_filename = args.file
    with open(csv_filename, newline="") as csv_file:
        csv_reader = csv.reader(csv_file)
        csv_writer = csv.writer(sys.stdout, quoting=csv.QUOTE_MINIMAL, dialect="my_format")

        for line_count, row in enumerate(csv_reader):
            if line_count == 0:
                pass
            else:
                row = process_row(row)
            csv_writer.writerow(row)


if __name__ == "__main__":
    main()
