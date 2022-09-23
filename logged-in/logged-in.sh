#!/bin/bash

E_BADARGS=65

PROGNAME=$(basename $0)

if [ -z $1 ]; then
    echo "Usage: $PROGNAME [who/last]"
    exit $E_BADARGS
fi

COMMAND="$1"

case $COMMAND in
    who )       echo -en "These are the users online:\n"
                who -H ;;
    last )      echo -en "This is the list of last logged in users:\n"
                last ;;
    * )         echo "Usage: $PROGNAME [who/last]"
                exit $E_BADARGS
esac

exit 0