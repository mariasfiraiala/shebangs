#!/bin/bash

E_WRONGARGS=65
E_FILE_NOT_EXIST=66

PROGNAME=$(basename $0)

if [ $# -ne 1 ]; then
    echo "Usage: $PROGNAME file"
    exit $E_WRONGARGS
fi

if [ ! -e "$1" ]; then
    echo "File "$1" does not exist"
    exit $E_FILE_NOT_EXIST
fi

FILENAME=$1

while read word && [[ $word != end ]]; do
    if look "$word" > /dev/null; then
        echo "\"$word\" is valid."
    else
        echo "\"$word\" is invalid."
    fi
done <"$FILENAME"

exit 0