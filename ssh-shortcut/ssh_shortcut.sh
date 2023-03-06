#!/bin/bash

# script by sh

################
# SSH Shortcut #
################

# Usecase: Create a SSH-Config file for connecting to hosts quicker

################
# Feature-List #
################

# - Enter SSH-Connection Details, script will enter these with correct syntax to the ssh config
# - Planned: Search for Host and Change an Entry

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

#############
# Funktions #
#############

start_text () {
    echo -e "$Green  _________ _________ ___ ___     _________.__                   __                 __    $Color_Off"
    echo -e "$Green /   _____//   _____//   |   \   /   _____/|  |__   ____________/  |_  ____  __ ___/  |_  $Color_Off"
    echo -e "$Green \_____  \ \_____  \/    ~    \  \_____  \ |  |  \ /  _ \_  __ \   __\/ ___\|  |  \   __\ $Color_Off"
    echo -e "$Green /        \/        \    Y    /  /        \|   Y  (  <_> )  | \/|  | \  \___|  |  /|  |   $Color_Off"
    echo -e "$Green/_______  /_______  /\___|_  /  /_______  /|___|  /\____/|__|   |__|  \___  >____/ |__|   $Color_Off"
    echo -e "$Green        \/        \/       \/           \/      \/                        \/              $Color_Off"
    echo -e ""
    echo -e "$Green Script by sh $Color_Off"
    echo -e ""
    echo -e "$Yellow Press 'Ctrl + C' to exit the Programm $Color_Off"
}

ssh_input () {
    while true
    do
        read -p "Host: " host
        read -p "IP or FQDN: " hostname
        read -p "Port: " port
        read -p "User: " user
        echo "==============="
        echo ""
        echo -e "$Yellow Please Confirm: $Color_Off"
        echo ""
}

