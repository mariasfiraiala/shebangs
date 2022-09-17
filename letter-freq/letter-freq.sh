#!/bin/bash

PROGNAME=$(basename $0)

if [ -z "$1" ]; then
    echo "Usage: $PROGNAME file"
    exit 1
fi

FILENAME=$1

while read -n 1 ch; do
    echo "$ch"
done < "$FILENAME" | grep "[[:alpha:]]" | sort | uniq -c | sort -nr