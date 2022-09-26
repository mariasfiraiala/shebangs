#/bin/bash

E_BADARGS=65
E_NOT_A_DIR=66

PROGNAME=$(basename $0)

# if the 2 necessary arguments are missing, we promt
# the user and we exit

if [ $# -ne 2 ]; then
    echo "usage: $PROGNAME directory-1 directory-2" 1>&2
    exit $E_BADARGS
fi

# checking if the given directories are indeed directories

if [ ! -d "$1" ]; then
    echo "$1 is not a directory!" 1>&2
    exit $E_NOT_A_DIR
fi

if [ ! -d "$2" ]; then
    echo "$2 is not a directory!" 1>&2
    exit $E_NOT_A_DIR
fi

missing=0
for filename in "$1"/*; do
    # get the name of the every single file in the first directory
    fn=$(basename "$filename")
    if [ -f "$filename" ]; then
        # if the said file is missing from the second directory we increment
        # the variable used for counting the missing occurrences
        if [ ! -f "$2/$fn" ]; then
            echo "$fn is missing from $2"
            missing=$((missing + 1))
        fi
    fi
done

echo "$missing files missing"

exit 0
