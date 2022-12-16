#!/bin/bash

# script by sh

default_user=shoellein
Color_Off='\033[0m'
On_Green='\033[42m'

##################
# ubuntu-install #
##################

software_update () {
	apt update
	apt upgrade -f -y
}

software_install (){
	apt install net-tools htop iotop nload vim screen iperf3 screen neofetch git nmap zabbix-agent -y
}

########
# Main #
########

# update and upgrade
echo "Update repositorys and upgrade packages"
echo ""
software_update
echo ""

# basic tool installation
echo "install baseline Software-Collection"
echo ""
software_install
echo ""

neofetch
echo ""