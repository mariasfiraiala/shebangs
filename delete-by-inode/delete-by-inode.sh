#!/bin/bash -x

# -x -> shows all the expansions done by the shell
#       very useful for debugging

E_BADARGS=70
E_FILE_NOT_EXIST=71
E_CHANGED_MIND=72

PROGNAME=$(basename $0)

# if the script doesn't have 1 argument, show the usage of the program
# and exit

if [ $# -ne 1 ]; then
    echo "Usage: $PROGNAME file"
    exit $E_BADARGS
fi

if [ ! -e "$1" ]; then
    echo "File "$1" does not exist"
    exit $E_FILE_NOT_EXIST
fi

# get the inode

inum=$(ls -i "$1" | awk '{ print $1 }')

echo; echo -n "Are you absolutely sure you want to delete \"$1\" [y/n]? "
read answer

case "$answer" in
    [nN] )      echo "Changed your mind, huh?"
                exit $E_CHANGED_MIND
                ;;
    * )         echo "Deleting file \"$1\"."
esac

# search for the file, starting with root
# this may get you a lot of "Permission denied"s
# and be quite time consuming

find / -inum $inum -exec rm {} \;

echo "File \"$1\" deleted!"

exit 0