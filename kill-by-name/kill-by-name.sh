#!/bin/bash

E_WRONGARGS=66

PROGNAME=$(basename $0)

# The script must have one argument, the name of the process we want killed

if [ -z "$1" ]; then
    echo "Usage: $PROGNAME process"
    exit $E_WRONGARGS
fi

PROCESS_NAME="$1"

# ps ax -> see every process on the system using BSD syntax
# xargs -i kill {} -> kills every process found by awk

ps ax | grep "$PROCESS_NAME" | awk '{ print $1 }' | xargs -i kill {} 2&>/dev/null

exit $?