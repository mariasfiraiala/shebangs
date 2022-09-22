#!/bin/bash

echo "Start configuring git..."

read -p "Type your preferred username: " username

default_email="$username@users.noreply.github.com"

read -p "Type your preferred email address [Press enter for the default email]: " email

email="${email:-${default_email}}"

echo "Configuring global username and email..."
git config --global user.name "$username"
git config --global user.email "$email"

read -r -p "Do you want to add ssh credentials for git? [y/n] " answer
case $answer in 
    "yY" )      echo "Configuring git ssh access..."
                ssh-keygen -t ed25519 -C "$email"
                echo -en "This is your public key.\n"
                echo -en "\tTo activate it in github, got to settings,\n" 
                echo -en "\tSHH and GPG keys, New SSH key, and enter the following key:\n"
                cat ~/.ssh/id_ed25519.pub
                echo "" ;;
    * )         echo -en "Living dangerously, I see\n"
esac

exit 0