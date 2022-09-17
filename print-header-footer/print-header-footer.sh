#/bin/bash

PROGNAME="$(basename $0)"

if [ -d "~/tmp" ]; then
    TEMP_DIR=~/tmp
else
    TEMP_DIR=/tmp
fi
TEMP_FILE="$TEMP_DIR/$PROGNAME.$$.$RANDOM"

usage()
{
    echo "Usage $PROGNAME file" 1>&2
}

clean_up()
{
    rm -f "$TEMP_FILE"
    exit $1
}

error_exit()
{
    echo "${PROG_NAME}: ${1:-"Unknown Error"}" 1>&2
    clean_up 1
}

trap clean_up SIGHUP SIGINT SIGTERM

if [ $# != "1" ]; then
    usage
    error_exit "one file to print must be specified"
fi

if [ ! -f "$1" ]; then
    error_exit "file $1 cannot be read"
fi

pr $1 > "$TEMP_FILE" || error_exit "cannot format file"

read -p "Print file? [y/n]: "
if [ "$REPLY" = "y" ]; then
    lpr "$TEMP_FILE" || error_exit "cannot print file"
fi

clean_up