#!/bin/bash

press_enter()
{
    # might as well use:
    # read -p "Press Enter to continue " enter

    echo -en "\nPress Enter to continue"
    read
    clear
}

selection=

# Let the user do whatever they want until they don't want anything anymore

until [ "$selection" = "0" ]; do
    echo "
    PROGRAM MENU
    1 - Display free disk space
    2 - Display free memory
    
    0 - Exit program
    "

    echo -n "Enter selection: "
    read selection
    echo ""

    case $selection in
        1 ) df ; press_enter ;;
        2 ) free ; press_enter ;;
        0 ) exit ;;
        * ) echo "Please enter 1, 2, or 0"; press_enter
    esac
done