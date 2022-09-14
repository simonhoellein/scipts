#!/bin/bash

##############################################
# Setup-Scipt for debian based installations #
##############################################

## Defie some Colors

    # Reset
    ENDCOLOR='\033[0m'       # Text Reset

    # Regular Colors
    Black='\033[0;30m'        # Black
    Red='\033[0;31m'          # Red
    Green='\033[0;32m'        # Green
    Yellow='\033[0;33m'       # Yellow
    Blue='\033[0;34m'         # Blue
    Purple='\033[0;35m'       # Purple
    Cyan='\033[0;36m'         # Cyan
    White='\033[0;37m'        # White

    # Bold
    BBlack='\033[1;30m'       # Black
    BRed='\033[1;31m'         # Red
    BGreen='\033[1;32m'       # Green
    BYellow='\033[1;33m'      # Yellow
    BBlue='\033[1;34m'        # Blue
    BPurple='\033[1;35m'      # Purple
    BCyan='\033[1;36m'        # Cyan
    BWhite='\033[1;37m'       # White

    # Underline
    UBlack='\033[4;30m'       # Black
    URed='\033[4;31m'         # Red
    UGreen='\033[4;32m'       # Green
    UYellow='\033[4;33m'      # Yellow
    UBlue='\033[4;34m'        # Blue
    UPurple='\033[4;35m'      # Purple
    UCyan='\033[4;36m'        # Cyan
    UWhite='\033[4;37m'       # White

    # Background
    On_Black='\033[40m'       # Black
    On_Red='\033[41m'         # Red
    On_Green='\033[42m'       # Green
    On_Yellow='\033[43m'      # Yellow
    On_Blue='\033[44m'        # Blue
    On_Purple='\033[45m'      # Purple
    On_Cyan='\033[46m'        # Cyan
    On_White='\033[47m'       # White

    # High Intensity
    IBlack='\033[0;90m'       # Black
    IRed='\033[0;91m'         # Red
    IGreen='\033[0;92m'       # Green
    IYellow='\033[0;93m'      # Yellow
    IBlue='\033[0;94m'        # Blue
    IPurple='\033[0;95m'      # Purple
    ICyan='\033[0;96m'        # Cyan
    IWhite='\033[0;97m'       # White

    # Bold High Intensity
    BIBlack='\033[1;90m'      # Black
    BIRed='\033[1;91m'        # Red
    BIGreen='\033[1;92m'      # Green
    BIYellow='\033[1;93m'     # Yellow
    BIBlue='\033[1;94m'       # Blue
    BIPurple='\033[1;95m'     # Purple
    BICyan='\033[1;96m'       # Cyan
    BIWhite='\033[1;97m'      # White

    # High Intensity backgrounds
    On_IBlack='\033[0;100m'   # Black
    On_IRed='\033[0;101m'     # Red
    On_IGreen='\033[0;102m'   # Green
    On_IYellow='\033[0;103m'  # Yellow
    On_IBlue='\033[0;104m'    # Blue
    On_IPurple='\033[0;105m'  # Purple
    On_ICyan='\033[0;106m'    # Cyan
    On_IWhite='\033[0;107m'   # White

# Global Vars
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SOFTWARE="net-tools tmux zabbix-agent ncdu htop glances vim mc fzf fd-find lynx tldr open-vm-tools screen iperf3 nmap traceroute"

# Decoration

echo "               __                          .__      "
echo "  ______ _____/  |_ __ ________       _____|  |__   "
echo " /  ___// __ \   __\  |  \____ \     /  ___/  |  \  "
echo " \___ \\  ___/|  | |  |  /  |_> >    \___ \|   Y  \ "
echo "/____  >\___  >__| |____/|   __/ /\ /____  >___|  / "
echo "     \/     \/           |__|    \/      \/     \/  "
echo ""
echo -e "${BYellow}script by: shl${ENDCOLOR}"
echo ""
echo -e "${Green}setup script for debian based linux distributions${ENDCOLOR}"
echo ""

# Checks
OS=$(cat /etc/*-release | grep "PRETTY_NAME" | cut -d "=" -f 2)
Kernel=`uname -r`
HWPlatform=`uname -p`
TIME=`date`
echo "System Information:"
echo ""
echo "Hostname:       $HOSTNAME"
echo "logged in as:   $USER"
echo "Kernel:         $Kernel" 
echo "Platform:       $HWPlatform"
echo "OS:             $OS"
echo "Time            $TIME"
echo ""
echo "this script must be run as root or with sudo rights!"
echo ""
if [ "$EUID" -ne 0 ]
then
    echo -e "${BRed}you are not running as root!${ENDCOLOR}"
    exit 1
else 
    echo -e "${On_Green}  OK  ${ENDCOLOR} Running as ${USER}"
fi
echo ""
echo -e "${Purple}[CHECK]${ENDCOLOR} Check Internet-Connection"

PING_T=$(ping 1.1.1.1 -c 4 | grep "rtt min/avg/max" | cut -d "=" -f 2 | cut -d "/" -f 2)
PING_L=$(ping 1.1.1.1 -c 4 | grep "packets transmitted" | cut -d "," -f 3 | cut -d "%" -f 1 | sed -e 's/^[[:space:]]*//')

PING_T="${PING_T//[$'\t\r\n ']}"

if [ "$PING_L" -eq 0 ]
then
    echo -e "${On_Green}  OK  ${ENDCOLOR} Internet"
    echo -e "${On_Green}  OK  ${ENDCOLOR} Package Loss ($PING_L %)"
elif [ "$PING_L" -gt 0 ]
then
    echo -e "${On_Green}  OK  ${ENDCOLOR} Internet"
    echo -e "${On_Yellow} WARN ${ENDCOLOR} Package Loss ($PING_L %)"
else [ "$PING_L" -eq 100 ]
    echo -e "${On_Red}  ER  ${ENDCOLOR} Internet"
    echo -e "${On_Red}  ER  ${ENDCOLOR} Package Loss ($PING_L %)"
fi

if [ "$PING_T" = "0" ]
then
    echo -e "${On_Red}  ER  ${ENDCOLOR} Latency"
elif [ "$PING_T" > "50" ]
then
    echo -e "${On_Green}  OK  ${ENDCOLOR} Latency ($PING_T ms)"
else [ "$PING_T" < "50" ]
    echo -e "${On_Yellow} WARN ${ENDCOLOR} Latency ($PING_T ms)"
fi
echo ""

echo -e "${Purple}[CHECK]${ENDCOLOR} Internet Speed"
apt install speedtest-cli -y
SPEED_DOWN=$(speedtest --no-upload | grep "Download:" | cut -d ":" -f 2 | sed -e 's/^[[:space:]]*//')
SPEED_UP=$(speedtest --no-download | grep "Upload:" | cut -d ":" -f 2 | sed -e 's/^[[:space:]]*//') 

SPEED_DOWN=${SPEED_DOWN::-7}
SPEED_UP=${SPEED_UP::-7}

SPEED_DOWN="${SPEED_DOWN//[$'\t\r\n ']}"
SPEED_UP="${SPEED_UP//[$'\t\r\n ']}"

if [ "$SPEED_DOWN" -lt "100" ]
then
    echo -e "${On_Yellow} WARN ${ENDCOLOR} Internet-Speed ($SPEED_DOWN Mbit/s)"
else
    echo -e "${On_Green}  OK  ${ENDCLOLOR} Internet-Speed ($SPEED_DOWN Mbit/s)"
fi



echo -e "${Purple}[UPDATE]${ENDCOLOR} Updating Repos"
apt update && apt upgrade -y
echo ""

echo -e "${Purple}[INSTALL]${ENDCOLOR} Install Software"
apt install $SOFTWARE -y
echo ""

echo -e "${Purple}[CONFIGURATION]${ENDCOLOR} Configure Zabbix-Client"
sed -i -e 's/Server=127.0.0.1/Server=192.168.0.21/g' /etc/zabbix/zabbix_agentd.conf
sed -i -e 's/ServerActive=127.0.0.1/ServerActive=192.168.0.21/g' /etc/zabbix/zabbix_agentd.conf
systemctl enable zabbix-agent
systemctl restart zabbix-agent
systemctl status zabbix-agent
echo ""

echo -e "${Purple}[CONFIGURATION]${ENDCOLOR} Configure Timezone"
timedatectl set-timezone Europe/Berlin
echo "time information"
timedatectl
echo ""

