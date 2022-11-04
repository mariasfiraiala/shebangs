#!/bin/bash

PROGNAME=$(basename $0)

if [ -z "$1" ]; then
    echo "Usage: $PROGNAME file"
    exit 1
fi

FILENAME=$1

# read characher by character from the given file
# grep "[[:alpha:]]" -> gets the alphabetic characters
# uniq -c -> counts the occurances of the letters
while read -n 1 ch; do
    echo "$ch"
done < "$FILENAME" | grep "[[:alpha:]]" | sort | uniq -c | sort -nr