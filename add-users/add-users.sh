#!/bin/bash

GROUP_NAME="test"
GROUP_DIR="test"
QUOTA="256"
ROOT_UID="0"

E_BADARGS=65
E_NOTROOT=66

PROGNAME=$(basename $0)

usage()
{
    echo -en "Usage: $PROGNAME [username] [email address] [info]\n"
    echo -en "\tif arguments are missig, the script user will be\n"
    echo -en "\tprompted for them\n"
}

if [ "$UID" != "$ROOT_UID" ]; then
    echo "Must be root to run this script"
    exit $E_NOTROOT
fi

if [ $# -gt "3" ]; then
    usage
    exit $E_BADARGS
fi

if [ $# -ge 1 ]; then
    username="$1"
else
    read -p "Username: " username
fi

if [ $# -eq 3 ]; then
    comment="$3"
else
    read -p "Info: " comment
fi

useradd -m -d /home/$GROUP_DIR/$username -g $GROUP_NAME -c "$comment" -s /bin/bash $username

password=$(pwgen -N 1)

echo "$username:$password" | chpasswd

setquota $username $(($QUOTA * 1024)) $((($QUOTA + 10) * 1024)) $(($QUOTA * 100)) $((($QUOTA + 10) * 100)) -a

if [ $# -ge 2 ]; then
    email="$2"
else
    read -p "Email address: " email
fi

cat ./new_user_mail_message.txt | sed "s/username/$username/g" | sed "s/quota/$QUOTA/g" | sed "s/password/$password/g" | mail -s "Test account" $email

exit 0
