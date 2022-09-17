#!/bin/bash

E_WRONGARGS=66

PROGNAME=$(basename $0)

if [ -z "$1" ]; then
    echo "Usage: $PROGNAME process"
    exit $E_WRONGARGS
fi

PROCESS_NAME="$1"
ps ax | grep "$PROCESS_NAME" | awk '{ print $1 }' | xargs -i kill {} 2&>/dev/null

exit $?