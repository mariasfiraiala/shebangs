#!/bin/bash

GROUP_NAME="test"
GROUP_DIR="test"
QUOTA="256"
ROOT_UID="0"

E_BADARGS=65
E_NOTROOT=66

PROGNAME=$(basename $0)

# function to prompt the user with the correct usage of the script 

usage()
{
    # echo -en -> -n do not output the trailing newline
    #             -e enable interpretation of backslash escapes

    echo -en "Usage: $PROGNAME [username] [email address] [info]\n"
    echo -en "\tif arguments are missig, the script user will be\n"
    echo -en "\tprompted for them\n"
}

# self explanatory, you need to be admin to run this script;
# UID is a environmental variable which stores the uid of the current user

if [ "$UID" != "$ROOT_UID" ]; then
    echo "Must be root to run this script"
    exit $E_NOTROOT
fi

# $# -> the number of parameters for the script, its C equivalent is argc
# if there are more than 3 arguments, something's wrog, we promp the user
# and we exit

if [ $# -gt "3" ]; then
    usage
    exit $E_BADARGS
fi

# if there are more than 1 arguments then the first one
# (besides $0 -> the script name) must be the new username
# otherwise we'll ask the user directly for it

if [ $# -ge 1 ]; then
    username="$1"
else
    # read -p <prompt> -> outputs the prompt string before reading user input
    read -p "Username: " username
fi

# we'll also either ask for comment, or take it from the argument, if the
# argument exists

if [ $# -eq 3 ]; then
    comment="$3"
else
    read -p "Info: " comment
fi

# Let's get down to business!
###############################################################################

# useradd -> -m create the user's home directory if it doesn't exist
#            -d the new user will be created with the given directory
#               as the login home
#            -g user's group name/number
#            -c a short description of the login, used as the field for the
#               user's full name
#            -s the name of the user's login shell


useradd -m -d /home/$GROUP_DIR/$username -g $GROUP_NAME -c "$comment" -s /bin/bash $username

# pwgen -N <num> -> generate num passwords; this defaults to a screenful
#                   if passwords are printed by columns, and one password. 

password=$(pwgen -N 1)

# chpasswd -> update passwords in batch mode

echo "$username:$password" | chpasswd

# A quota is a built-in feature of the linux kernel that is used to set a
# limit of how much disk space a user or a group can use. It is also used to
# limit the maximum number of files a user or a group can create on linux

setquota $username $(($QUOTA * 1024)) $((($QUOTA + 10) * 1024)) $(($QUOTA * 100)) $((($QUOTA + 10) * 100)) -a

# ask the user for email address

if [ $# -ge 2 ]; then
    email="$2"
else
    read -p "Email address: " email
fi

# send mail with the new login info to the user

cat ./new_user_mail_message.txt | sed "s/username/$username/g" | sed "s/quota/$QUOTA/g" | sed "s/password/$password/g" | mail -s "Test account" $email

exit 0
