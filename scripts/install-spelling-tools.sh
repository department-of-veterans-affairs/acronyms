#!/usr/bin/env bash
# Installs hunspell and spelling dictionaries (en_US and medical English)
# Note: Only tested on OSX 10.14/12.2, may not work on other operating systems

set -e

if [ "$(uname)" != "Darwin" ]; then
  echo "Only tested on OSX"
  exit 1
fi

brew install hunspell

# Install hunspell en_US dictionaries
curl https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_US.aff --output ~/Library/Spelling/en_US.aff
curl https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_US.dic --output ~/Library/Spelling/en_US.dic
# Install medical dictionary
curl https://raw.githubusercontent.com/Glutanimate/hunspell-en-med-glut/master/en_med_glut.dic --output ~/Library/Spelling/en_med_glut.dic
