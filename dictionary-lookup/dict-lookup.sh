#!/bin/bash

E_BADARGS=65
E_FILE_NOT_EXIST=66

PROGNAME=$(basename $0)

# if the first arguments is omitted, we print the usage
# and exit

if [ $# -ne 1 ]; then
    echo "Usage: $PROGNAME file"
    exit $E_BADARGS
fi

# if the file for which we check its words doesn't exist
# we exit

if [ ! -e "$1" ]; then
    echo "File "$1" does not exist"
    exit $E_FILE_NOT_EXIST
fi

FILENAME=$1

# look will check if the given word exists in /usr/share/dict/words

while read word && [[ $word != end ]]; do
    if look "$word" > /dev/null; then
        echo "\"$word\" is valid."
    else
        echo "\"$word\" is invalid."
    fi
done <"$FILENAME"

exit 0