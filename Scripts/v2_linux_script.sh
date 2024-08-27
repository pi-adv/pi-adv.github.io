#!/bin/bash

scriptpart=0
option=0
accman=0
groman=0
proman=0

bold=$(tput bold)
normal=$(tput sgr0)


echo "${bold}This program is only for Cybertitan Competition use! Beware when using on a personal machine!${normal}"

sleep 3

clear

echo "Welcome to the TQNFOY Linux script!"


echo "Here are the current Users and Groups on the system."
echo ""
echo "${bold}Are you running this script on purpose?${normal}"
read -p "[y/n]" play



startup () {
    clear
    echo "-----------------------"
    echo "What would you like to do?
        1. Account Management
        2. Group Management
        3. Programs
        !! Visit pi-adv.github.io for more info !!"
   
    read -p [1-3] option

    if [ $option == 1 ]
    then
        accountmanager
    elif [ $option == 2 ]
    then
        groupmanager
    elif [ $option == 3 ]
    then
        programmanger
    fi
}

accountmanager () {
    clear

    echo "Welcome to the Account Management section. Here is what you can do:"
    echo "1. Add Users
2. Remove Users
3. Change Account Type
4. Change Password
5. BACK <--
______________________"

    accman=0
    read -p [1-5] accman

    if [ $accman == 5 ]
    then
        startup
    fi

}

groupmanager () {
    clear

    echo "Welcome to the Group Management section. Here is what you can do:"
    echo "1. Create a Group
2. Delete a Group
3. Add a User to Group
4. Delete a User to Group
5. BACK <--
______________________"
    
    groman=0
    read -p [1-5] groman

    if [ $groman == 5 ]
    then
        startup
    fi

}

programmanger () {
    clear

    echo "Welcome to the Program Management section. Here is what you can do:"
    echo "1. Install a Program
2. Remove/Purge a Program
3. Remove Known Malicious Programs
4. Install/Update Critical Services
5. BACK <--
______________________"

    proman=0
    read -p [1-5] proman

    if [ $proman == 5 ]
    then
        startup 
    fi
    
}

if [ $play == "y" ]
then
    startup
fi

while [ $accman == 1 ]
do
    clear 

    echo "Welcome to Adding Users."
    echo "Here are the list of Users on the system."
    echo "-----------------------"
    getent passwd {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"
    echo "Give the name of the user to add:"
    read -p User: newuser

    clear
    
    echo "Adding..."
    sudo useradd $newuser 
    echo "DONE"
    pause
    
    clear

    echo "Is this an Administrator?"
    read -p [y/n] admin
    if [ $admin == "y" ]
    then
        sudo adduser $newuser sudo
    fi

    clear

    echo "Set a password for $newuser ?"
    read -p [y/n] passwset
    if [ $passwset == "y" ]
    then
        sudo passwd $newuser
    fi

    clear

    echo "Add another user?"
    read -p [y/n] addmoreusers
    if [ $addmoreusers == "y" ]    
    then
        continue
    elif [ $addmoreusers == "n" ]
    then
        accountmanager
    fi

    clear
done

while [ $accman == 2 ]
do
    clear

    echo "Welcome to Removing Users."
    echo "Here are the current Users on the System:"
    echo "-----------------------"
    getent passwd {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"
    echo "Give the name of the user to remove:"
    read -p User: removeuser

    clear
    
    echo "Do you want to keep the User's Files?"
    read -p [y/n] keepuserfiles

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
    echo "DONE"
    pause
    
    clear

    echo "Remove another user?"
    read -p [y/n] removemoreusers
    if [ $removemoreusers == "y" ]    
    then
        continue
    elif [ $removemoreusers == "n" ]
    then
        accountmanager
    fi

    clear
done

while [ $accman == 3 ]
do
    clear

    echo "Welcome to Change Account Types"

    echo "Here are the Administators on the system."
    echo "-----------------------"
    getent group sudo | cut -d: -f4
    echo "-----------------------"

    echo "Here are the list of Users on the system."
    echo "-----------------------"
    getent passwd {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"

    echo "Give the user to change its account type:"
    read -p User: acctypeuser

    echo "Would you like to make this account a standard or admin?"
    read -p [s/a] acctypeforuser
    
    if [ $acctypeforuser == "s" ]
    then
        echo "Changing $acctypeuser's account type to standard..."
        sudo deluser $acctypeuser sudo
        echo "DONE"
        sleep 2
    elif [ $acctypeforuser == "a" ]
    then
        echo "Changing $acctypeuser's account type to admin..."
        sudo usermod -aG sudo $acctypeuser
        echo "DONE"
        sleep 2
    fi

    clear

    echo "Change another Account Type?"
    read -p [y/n] acctypeagain
    if [ $acctypeagain == "y" ]    
    then
        continue
    elif [ $acctypeagain == "n" ]
    then
        accountmanager
    fi

    clear
done

while [ $accman == 4 ]
do
    clear

    echo "Welcome to Changing Passwords"

    echo "Here are the list of Users on the system."
    echo "-----------------------"
    getent passwd {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"

    echo "Give the user to change its password:"
    read -p User: passchanuser

    clear

    echo "Changing $passchanuser Password..."
    sudo passwd $passchanuser
    echo "DONE"
    pause

    clear

    echo "Change another Password?"
    read -p "[y/n]" passchangeagain
    if [ $passchangeagain == "y" ]    
    then
        continue
    elif [ $passchangeagain == "n" ]
    then
        accountmanager
    fi

    clear
done

while [ $groman == 1 ]
do
    clear

    echo "Welcome to Creating a Group."
    echo "Here are the Groups that are already created:"
    echo "-----------------------"
    getent group {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"
    echo "Give a name for your Group."
    read -p Name: addgroup

    clear
    
    echo "Do you want to manually give the Group a GID?"
    read -p [y/n] gidforgroup

    if [ $gidforgroup == "y" ]
    then
        echo "What GID do you want for the Group?"
        read -p 1000 minimum: gidnumber
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

    echo "Create another Group?"
    read -p [y/n] createanothergroup
    if [ $createanothergroup == "y" ]    
    then
        continue
    elif [ $createanothergroup == "n" ]
    then
        groupmanager
    fi 
    clear
done

while [ $groman == 2 ]
do
    clear

    echo "Welcome to Removing a Group."
    echo "Here are the Groups that are already created:"
    echo "-----------------------"
    getent group {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"
    echo "Give the name of the Group to remove."
    read -p Name: removegroup

    clear

    echo "Removing the Group..."
    sudo groupdel $removegroup
    echo "DONE"
    sleep 2

    clear

    echo "Delete another Group?"
    read -p [y/n] deleteanothergroup
    if [ $deleteanothergroup == "y" ]    
    then
        continue
    elif [ $deleteanothergroup == "n" ]
    then
        groupmanager
    fi

    clear
done

while [ $groman == 3 ]
do
    clear

    echo "Welcome to Adding Users to Group."
    echo "Here are the Groups that are already created:"
    echo "-----------------------"
    getent group {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"
    echo "Select the Group to add the user to."
    read -p Group: addusertogroup

    clear
    
    echo "Here are the Users on the system."
    echo "-----------------------"
    getent passwd {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"
    read -p What user to add to group: userstogroup

    clear 

    echo "Adding User to Group...."
    sudo usermod -aG $addusertogroup $userstogroup
    echo "DONE"
    sleep 2

    clear

    echo "Add Users to another Group?"
    read -p [y/n] addusertogroup
    if [ $addusertogroup == "y" ]    
    then
        continue
    elif [ $addusertogroup == "n" ]
    then
        groupmanager
    fi

    clear
done

while [ $groman == 4 ]
do
    clear

    echo "Welcome to Removing a User from a Group."
    echo "Here are the Groups that are already created:"
    echo "-----------------------"
    getent group {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"
    echo "Select the Group to add the user to."
    read -p Group: delusertogroup

    clear
    
    echo "Here are the Users on the system."
    echo "-----------------------"
    getent passwd {1000..8000} | awk -F: '{print $1}'
    echo "-----------------------"
    read -p User: delusertogroup

    clear 

    echo "Removing User from Group...."
    sudo deluser $delusertogroup $deluserstogroup
    echo "DONE"
    sleep 2

    clear

    echo "Add Users to another Group?"
    read -p [y/n] delusertogroup
    if [ $delusertogroup == "y" ]    
    then
        continue
    elif [ $delusertogroup == "n" ]
    then
        groupmanager
    fi

    clear
done

while [ $proman == 1 ]
do
    clear 

    echo "Welcome to Installing Programs."
    echo "What would you like to install?"
    read -p Package: programinstall

    clear 

    echo "Installing $programinstall..."
    sudo apt install $programinstall
    echo "DONE"
    sleep 2

    clear 

    echo "Would you like to install another program?"
    read -p [y/n] anotherprogram
    if [ $anotherprogram == "y" ]
    then
        continue
    elif [ $anotherprogram == "n" ]
    then
        programmanger
    fi

    clear

done

while [ $proman == 2 ]
do
    clear

    echo "Welcome to Removing Programs."
    echo "What program would you like to remove?"
    read -p Package: removeprogram

    clear 

    echo "Removing $removeprogram"
    sudo apt purge $removeprogram
    echo "DONE"
    sleep 2

    clear 

    echo "Would you like to remove another program?"
    read -p [y/n] remanotherprogram

    if [ $remanotherprogram == "y" ]
    then
        continue
    elif [ $remanotherprogram == "n" ]
    then 
        programmanger
    fi

    clear 

done

while [ $proman == 3 ]
do
    clear

    echo "Welcome to Removing/Purging Known Malicious Programs."
    echo "Here are some malicious programs that you can remove:"
    echo -e "1. nmap"
    echo -e "2. wireshark"
    echo -e "3. ophcrack"
    echo -e "4. hydra"
    echo -e "5. john"
    echo -e "6. nginx"
    echo "7. ALL"

    read -p [1-7] malremove

    clear

    if [ $malremove == 1 ]
    then
        echo "Removing nmap..."
        sudo apt purge nmap
        echo "DONE"
        sleep 2
    elif [ $malremove == 2 ]
    then
        echo "Removing wireshark..."
        sudo apt purge wireshark
        echo "DONE"
        sleep 2
    elif [ $malremove == 3 ]
    then 
        echo "Removing ophcrack..."
        sudo apt purge ophcrack
        echo "DONE"
        sleep 2
    elif [ $malremove == 4 ]
    then 
        echo "Removing hydra..."
        sudo apt purge hydra
        echo "DONE"
        sleep 2
    elif [ $malremove == 5 ]
    then
        echo "Removing john..."
        sudo apt purge john
        echo "DONE"
        sleep 2
    elif [ $malremove == 6 ]
    then
        echo "Removing nginx..."
        sudo apt purge nginx
        echo "DONE"
        sleep 2
    elif [ $malremove == 7 ]
    then
        echo "Removing all malicious software listed..."
        sudo apt purge nmap wireshark ophcrack hydra john nginx
        echo "DONE"
        sleep 2
    fi


    clear

    echo "Remove more malicious programs?"
    read -p [y/n] malremagain
    if [ $malremagain == "y" ]    
    then
        continue
    elif [ $malremagain == "n" ]
    then
        programmanger
    fi

    clear
done

while [ $proman == 4 ]
do
    clear

    echo "Welcome to Updating Critical Programs."
    echo "Here are some critical services you can update:"
    echo -e "1. openssh"
    echo -e "2. ufw"
    echo -e "3. apache2"
    echo -e "4. vsftpd"
    echo "5. ALL"

    echo "What program would you like to update?"
    read -p [1-5] programtoupdate

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
    elif [ $programtoupdate == 3 ]
    then
        echo "Updating Apache2 Web Service..."
        sudo apt install apache2
        echo "DONE"
        sleep 2
    elif [ $programtoupdate == 4 ]
    then
        echo "Updating vsftpd service..."
        sudo apt install vsftpd
        echo "DONE"
        sleep 2
    elif [ $programtoupdate == 5 ]
    then
        echo "Updating all Critical Services..."
        sudo apt install openssh-server openssh-client ufw apache2 vsftpd
        echo "DONE"
        sleep 2
    fi

    clear

    echo "Update another service?"
    read -p [y/n] updateservice
    if [ $updateservice == "y" ]    
    then
        continue
    elif [ $updateservice == "n" ]
    then
        programmanger
    fi

    clear
done

while [ $option == 4 ]
do
    echo "EXITING PROGRAM"
    sleep 1
    exit
done