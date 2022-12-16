#!/bin/bash

# script by sh

###############
# Linux Setup #
###############

# Usecase: Quickly setup a new linux server with all config files and utilitys needed for a base installation

################
# Feature-List #
################

# - Installation of the following tools:
#       - sudo
#       - net-tools
#       - htop
#       - iotop
#       - nload
#       - vim
#       - screen
#       - iperf3
#       - nmap
#       - git
#       - 
# - Cloning "dotfiles" repository and move files to the belonging location
# - Network-Configuration
# - Installation of ssh-keys
# - Updates and Upgrades
# - Visual improvements to bash-shell
# - and all of this for different linux systems :)
#
#
# Supported Systems:
#       - Ubuntu Server 20.04LTS
#       - Ubuntu Server 22.04LTS
#       - Debian 10
#       - Debian 11
#       - CentOS 7

##############
# Color-Vars #
##############

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

###############
# Global Vars #
###############

default_user=shoellein

#############
# Funktions #
#############

logging () {
    log_location=~
    exec > >(tee -i $log_location/install.log)
    exec 2>&1
    echo -e "$On_Green[  OK  ]$Color_Off Logging Enabled"
    echo "Log Location: $log_location"
    echo ""
}

start_text () {
echo -e "$Yellow.____    .__                                _________       __                $Color_Off"
echo -e "$Yellow|    |   |__| ____  __ _____  ___          /   _____/ _____/  |_ __ ________  $Color_Off"
echo -e "$Yellow|    |   |  |/    \|  |  \  \/  /  ______  \_____  \_/ __ \   __\  |  \____ \ $Color_Off"
echo -e "$Yellow|    |___|  |   |  \  |  />    <  /_____/  /        \  ___/|  | |  |  /  |_> >$Color_Off"
echo -e "$Yellow|_______ \__|___|  /____//__/\_ \         /_______  /\___  >__| |____/|   __/ $Color_Off"
echo -e "$Yellow        \/       \/            \/                 \/     \/           |__|    $Color_Off"
}

check_operating_user () {
    if [[ $USER != "$default_user" ]]
    then
        #echo -e "$On_Red[  FAILED  ]$Collor_Off"
        echo "run script with user $default_user"
        exit
    else
        #echo -e "$On_Green[  OK  ]$Collor_Off"
        echo "User = $USER"
        echo ""
    fi
}

get_operating_system () {
    OS_NAME=$(cat /etc/os-release | grep "PRETTY_NAME=")
    echo "Getting OS-Name from /etc/os-release"
    echo "String: $OS_NAME"
    if  [[ $OS_NAME == *"Debian"* ]]; then
        echo -e "$On_Green[  OK  ]$Color_Off Set 'OS' to DEBIAN"
        os=debian.install.sh
    elif [[ $OS_NAME == *"Ubuntu"* ]]; then
        echo -e "$On_Green[  OK  ]$Color_Off Set 'OS' to UBUNTU"
        os=ubuntu.install.sh
    elif [[ $OS_NAME == *"CentOS"* ]]; then
        echo -e "$On_Green[  OK  ]$Color_Off Set 'OS' to CENTOS"
        os=centos.install.sh
    else
        echo -e "$On_Red[   FAILED   ]$Color_Off Operating System is not Supported"
        exit
    fi
}

summary () {
    echo -e "$On_Yellow[  CHECK  ]$Color_Off Confirm following parameters"
    echo ""
    echo "Running as user   = $USER"
    echo "Default user      = $default_user"
    echo "Home-Directory    = $HOME"
    echo ""
    echo "Operating System  = $OS_NAME"
    echo "Install-File      = $os"
    echo ""
    echo "==================================="
}

call_utility_installation () {
    cd os.install
    if [[ $os == *"debian"* ]]; then
        su -c ./$os root
    elif [[ $os == *"ubuntu"* ]]; then
        sudo -u root ./$os
    fi
}

#########################
# MAIN - Top-level Code #
#########################

# decoration
start_text
echo ""

# check user
check_operating_user
echo ""

# get OS
get_operating_system
echo ""

# summary and Confirmation
summary
read -p "Continue? [y/N]" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo ""
        echo ""
        call_utility_installation
    else
        exit
    fi
