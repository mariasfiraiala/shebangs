#!/bin/bash

LOG_DIR=/var/log
ROOT_UID=0
LINES=50

E_BADARGS=65
E_CANT_CD=66
E_NOTROOT=67

PROGNAME=$(basename $0)

if [ "$UID" -ne "$ROOT_UID" ]; then
    echo "Must be root to run this script"
    exit $E_NOTROOT
fi

case $1 in
    "" )        lines=50 ;;
    *[!0-9]* )  echo "Usage: $PROGNAME lines";
                exit $E_BADARGS ;;
    * )         lines=$1
esac

cd $LOG_DIR

if [ "$PWD" != "$LOG_DIR" ]; then
    echo "Can't change directory to $LOG_DIR"
    exit $E_CANT_CD
fi

tail -$lines messages > msg.temp
mv msg.temp messages

cat /dev/null > wtmp
echo "Logs cleaned up"

exit 0
