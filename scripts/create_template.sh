#!/bin/bash

set -e

if [ $# -eq 0 ]; then
  echo "No arguments supplied"
  echo "Usage: $0 /path/to/file/pancake.md"
  exit 1
fi

CONTENT=template
DIRNAME=$(dirname ${1})
BASENAME=$(basename ${1})
FILENAME=$(basename -s .md ${1}|sed -e 's/_/ /g' -e 's/-/ /g')

template() {
cat <<EOF
# ${FILENAME^}

This is a simple example of ${FILENAME}, but it is amazingly delicious.

## Hardware

* {HARDWARE}
* {HARDWARE}
* {HARDWARE}

## Ingredients

* {INGREDIENT}
* {INGREDIENT}
* {INGREDIENT}

## Instructions

1. {INSTRUCTIONS}
2. {INSTRUCTIONS}
3. {INSTRUCTIONS}

## Notes and Tips

* {NOTETIP}
* {NOTETIP}

## Log

|Date|Alterations|Results|
|---|---|---|
|01-01-2021|EXAMPLE|EXAMPLE: the results where good|

EOF
}


if [ ! -d ${DIRNAME} ]; then
  echo "Directory doesn't exist!"
  echo -n "Make it? [Y/n]:"

  read MAKEIT

  case $MAKEIT in
    n|N)
      echo "Aborting!"
      exit 1
      ;;
    y|Y)
      mkdir -p ${DIRNAME}
      ;;
    "")
      mkdir -p ${DIRNAME}
      ;;
    *)
      echo "Invalid option, aborting!"
      exit 1
      ;;
  esac
fi

case ${BASENAME} in
  *.md|*.MD)
    template > $DIRNAME/$BASENAME
    ;;
  *)
    echo "File extension invalid! Must end in .md"
    exit 1
    ;;
esac
