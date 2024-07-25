#!/bin/bash

scriptpart=0

bold=$(tput bold)
normal=$(tput sgr0)


echo "${bold}This program is only for Cybertitan Competition use! Beware when using on a personal machine!${normal}"

sleep 3

clear

echo "Welcome to the TQNFOY Linux script!"


echo "Here are the current Users and Groups on the system."
echo ""
echo "${bold}Are you running this script on purpose?${normal} [y/n]"
read -r play



startup () {
    clear
    echo "-----------------------"
    echo "What would you like to do? [1-8]
        1. Add Users
        2. Remove Users
        3. Create a Group
        4. Deleting a Group
        5. Adding a User to a Group
        6. Install a program
        7. Uninstall a program
        8. Update a Program
        9. Exit"
    
    echo "-----------------------"
    echo "${bold}USERS:${normal}"
    echo "-----------------------"
    getent passwd {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"

    echo "${bold}GROUPS:${normal}"
    echo "-----------------------"
    getent group {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"

    echo "${bold}Critical Services Installed:${normal}"
    echo ""
    echo "OpenSSH:"
    apt list --installed | grep openssh-server
    echo "IF NO PACKAGE IS HERE THAN NOT INSTALLED"
    echo "-----------------------"
    echo "UFW"
    apt list --installed | grep ufw
    echo "IF NO PACKAGE IS HERE THAN NOT INSTALLED"
    echo "-----------------------"
   
    read whichscript
}

if [ $play == "y" ]
then
    startup
fi

while [ $whichscript == 1 ]
do
    clear 

    echo "Welcome to Adding Users."
    echo "Here are the list of Users on the system."
    echo "-----------------------"
    getent passwd {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"
    echo "Give the name of the user to add:"
    read -r newuser

    clear
    
    echo "Adding..."
    sudo useradd $newuser
    
    clear

    echo "Is this an Administrator? [y/n]"
    read -r admin
    if [ $admin == "y" ]
    then
        sudo adduser $newuser sudo
    fi

    clear

    echo "Set a password for $newuser ? [y/n]"
    read -r passwset
    if [ $passwset == "y" ]
    then
        sudo passwd $newuser
    fi

    clear

    echo "Add another user? [y/n]"
    read -r addmoreusers
    if [ $addmoreusers == "y" ]    
    then
        continue
    elif [ $addmoreusers == "n" ]
    then
        startup
    fi

    clear
done

while [ $whichscript == 2 ]
do
    clear

    echo "Welcome to Removing Users."
    echo "Here are the current Users on the System:"
    echo "-----------------------"
    getent passwd {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"
    echo "Give the name of the user to remove:"
    read -r removeuser

    clear
    
    echo "Do you want to keep the User's Files? [y/n]"
    read -r keepuserfiles

    if [ $keepuserfiles == "y" ]
    then
        echo "Removing User & Keeping Files....."
        sudo userdel $removeuser
        echo "DONE"
        sleep 2
    elif [ $keepuserfiles == "n" ]
    then
        echo "Removing User & Deleting Files....."
        sudo userdel -r $removeuser
        echo "DONE"
        sleep 2
    fi

    echo "Removing..."
    sudo userdel $removeuser
    
    clear

    echo "Remove another user? [y/n]"
    read -r removemoreusers
    if [ $removemoreusers == "y" ]    
    then
        continue
    elif [ $removemoreusers == "n" ]
    then
        startup
    fi

    clear
done

while [ $whichscript == 3 ]
do
    clear

    echo "Welcome to Creating a Group."
    echo "Here are the Groups that are already created:"
    echo "-----------------------"
    getent group {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"
    echo "Give a name for your Group."
    read -r addgroup

    clear
    
    echo "Do you want to manually give the Group a GID? [y/n]"
    read gidforgroup

    if [ $gidforgroup == "y" ]
    then
        echo "What GID do you want for the Group (1000 minimum)?"
        read gidnumber
        echo "Creating Group with GID....."
        sudo groupadd -g $gidnumber $addgroup
        echo "DONE"
        sleep 2
    elif [ $gidforgroup == "n" ]
    then
        echo "Creating Group....."
        sudo groupadd $addgroup
        echo "DONE"
        sleep 2
    fi

    clear

    echo "Create another Group? [y/n]"
    read -r createanothergroup
    if [ $createanothergroup == "y" ]    
    then
        continue
    elif [ $createanothergroup == "n" ]
    then
        startup
    fi 
    
done

while [ $whichscript == 4 ]
do
    clear

    echo "Welcome to Removing a Group."
    echo "Here are the Groups that are already created:"
    echo "-----------------------"
    getent group {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"
    echo "Give the name of the Group to remove."
    read -r removegroup

    clear

    echo "Removing the Group..."
    sudo groupdel $removegroup
    echo "DONE"
    sleep 2

    clear

    echo "Delete another Group? [y/n]"
    read -r deleteanothergroup
    if [ $deleteanothergroup == "y" ]    
    then
        continue
    elif [ $deleteanothergroup == "n" ]
    then
        startup
    fi

    clear
done


while [ $whichscript == 5 ]
do
    clear

    echo "Welcome to Adding Users to Group."
    echo "Here are the Groups that are already created:"
    echo "-----------------------"
    getent group {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"
    echo "Select the Group to add the user to."
    read -r addusertogroup

    clear
    
    echo "Here are the Users on the system."
    echo "-----------------------"
    getent passwd {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"
    read -r userstogroup

    clear 

    echo "Adding User to Group...."
    sudo usermod -aG $addusertogroup $userstogroup
    echo "DONE"
    sleep 2

    clear

    echo "Add Users to another Group? [y/n]"
    read -r addusertogroup
    if [ $addusertogroup == "y" ]    
    then
        continue
    elif [ $addusertogroup == "n" ]
    then
        startup
    fi

    clear
done

while [ $whichscript == 6 ]
do
    clear

    echo "Welcome to Installing Programs."
    echo "What program would you like to install?"
    read -r programtoinstall

    clear
    
    echo "Installing Program..."
    sudo apt install $programtoinstall
    echo "DONE"
    sleep 2

    clear

    echo "Install another program? [y/n]"
    read -r anotherinstall
    if [ $anotherinstall == "y" ]    
    then
        continue
    elif [ $anotherinstall == "n" ]
    then
        startup
    fi

    clear
done


while [ $whichscript == 7 ]
do
    clear

    echo "Welcome to Uninstalling Programs."
    echo "What program would you like to uninstall?"
    read -r programtouninstall

    clear
    
    echo "Uninstalling Program..."
    sudo apt remove $programtouninstall
    echo "DONE"
    sleep 2

    clear

    echo "Uninstall another program? [y/n]"
    read -r anotheruninstall
    if [ $anotheruninstall == "y" ]    
    then
        continue
    elif [ $anotheruninstall == "n" ]
    then
        startup
    fi

    clear
done

while [ $whichscript == 8 ]
do
    clear

    echo "Welcome to Uninstalling Programs."
    echo "Here are some critical services you can update:
        1. OpenSSH
        2. UFW"
    echo "What program would you like to update? [1-2]"
    read  programtoupdate

    clear
    
    if [ $programtoupdate == 1 ]
    then 
        echo "Updating OpenSSH...."
        sudo apt install openssh-server openssh-client
        echo "DONE"
        sleep 2
    elif [ $programtoupdate == 2 ]
    then
        echo "Updating UFW....."
        sudo apt install ufw
        echo "DONE"
        sleep 2
    fi

    clear

    echo "Update another service? [y/n]"
    read -r updateservice
    if [ $updateservice == "y" ]    
    then
        continue
    elif [ $updateservice == "n" ]
    then
        startup
    fi

    clear
done

while [ $whichscript == 9 ]
do
    echo "EXITING PROGRAM"
    sleep 1
    exit
done