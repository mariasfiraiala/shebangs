#!/bin/bash -x

E_WRONGARGS=70
E_FILE_NOT_EXIST=71
E_CHANGED_MIND=72

PROGNAME=$(basename $0)

if [ $# -ne 1 ]; then
    echo "Usage: $PROGNAME file"
    exit $E_WRONGARGS
fi

if [ ! -e "$1" ]; then
    echo "File "$1" does not exist"
    exit $E_FILE_NOT_EXIST
fi

inum=$(ls -i "$1" | awk '{ print $1 }')

echo; echo -n "Are you absolutely sure you want to delete \"$1\" [y/n]? "
read answer

case "$answer" in
    [nN] )      echo "Changed your mind, huh?"
                exit $E_CHANGED_MIND
                ;;
    * )         echo "Deleting file \"$1\".";;
esac

find / -inum $inum -exec rm {} \;

echo "File \"$1\" deleted!"

exit 0