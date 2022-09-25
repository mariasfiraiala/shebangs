#!/bin/bash

LOG_DIR=/var/log
ROOT_UID=0

E_BADARGS=65
E_CANT_CD=66
E_NOTROOT=67

PROGNAME=$(basename $0)

if [ "$UID" -ne "$ROOT_UID" ]; then
    echo "Must be root to run this script"
    exit $E_NOTROOT
fi

# The script either has a number as an argument or nothing
# use case in order to check that

case $1 in
    "" )        lines=50 ;;
    *[!0-9]* )  echo "Usage: $PROGNAME lines";
                exit $E_BADARGS ;;
    * )         lines=$1
esac

cd $LOG_DIR

# if, for some reason, we were unable to change directories, prompt the user
# and exit gracefully

if [ "$PWD" != "$LOG_DIR" ]; then
    echo "Can't change directory to $LOG_DIR"
    exit $E_CANT_CD
fi

# Back to business: clear the logs

tail -$lines messages > msg.temp
mv msg.temp messages

cat /dev/null > wtmp
echo "Logs cleaned up"

exit 0
