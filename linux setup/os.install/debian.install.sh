#!/bin/bash

# script by sh

default_user=shoellein
Color_Off='\033[0m'
On_Green='\033[42m'

##################
# debian-install #
##################

software_update () {
	apt update
	apt upgrade -f -y
}

software_install (){
	apt install sudo net-tools htop iotop nload vim screen iperf3 screen neofetch git nmap zabbix-agent -y
}

networking () {
	while true
	do
		read -p "address: " address
		read -p "netmask: " netmask
  		read -p "gateway: " gateway

		ping=$(ping -c 4 $address | grep "packet loss" | cut -d "," -f 4 | cut -b 2-)
		if [[ $ping == *"100% packet loss"* ]]
		then
			echo -e "$On_Green[  OK  ]$Color_Off IP not in use. Continue..."

			interface=$(ip a | grep "2:" | cut -d ":" -f 2 -z | cut -b 2-)
			echo -e "$On_Green[  OK  ]$Color_Off Config for interface '$interface'"
			echo ""

			touch /etc/network/interfaces.d/"$interface"
			echo "iface $interface inet static" >> /etc/network/interfaces.d/"$interface"
			echo "address $address" >> /etc/network/interfaces.d/"$interface"
			echo "netmask $netmask" >> /etc/network/interfaces.d/"$interface"
			echo "gateway $gateway" >> /etc/network/interfaces.d/"$interface"

			head -n -3 /etc/network/interfaces > /etc/network/interfaces
  			service networking restart
  			systemctl status networking
			
			break
		else
			echo -e "$On_Red[  FAILED  ]$Color_Off IP is already in use!"
			continue
		fi
	done
}

sudo_config () {
  	echo -e "$On_Green[  OK  ]$Color_Off Adding user $default_user to sudoers-group"
  	usermod -a -G sudo $default_user
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

#configure Networking
echo "Configure Networking"
echo ""
read -p "Continue with Static IP Configuration? [Y/n]" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Continue"
	networking
else
	echo ""
	echo "Staying with DHCP...Alright"
fi

# adding user to sudoers group
echo ""
sudo_config
echo ""

neofetch
echo ""