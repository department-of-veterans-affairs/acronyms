#!/usr/bin/env bash

set -e
set -u

# location of acronyms file
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ACRONYMS_FILE="${SCRIPT_PATH}/../acronyms.csv"

if [ -z "${1:-}" ]; then
  echo "Usage: $0 [acronym]"
  exit 1
fi

if ! grep -i "^$1," "${ACRONYMS_FILE}"; then
  echo "No results found..."
  exit 1
fi
