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

cat "$1" | xargs -0 -n 1 | \

tr A-Z a-z | \

sed -e 's/\.//g'  -e 's/\,//g' -e 's/ /\
/g' | \

sort | uniq -c | sort -nr

exit 0