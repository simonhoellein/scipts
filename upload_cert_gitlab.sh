#!/bin/bash

#################
# Cert-Uploader #
#################

# Explenation: This Script is ment to upload Certificates from NGINX Proxy Manager to a Gitlab Repository

# Global Vars
WD=/tmp/cert-script/live
DIR_NUM=/tmp/cert-script/dir_num

# check if user is root
if [$USER -ne root]
then
    echo "This script mused be run as root. You are logged in as $USER"
    exit

# Copy Certfiles to Work-Directory and rm all README files
mkdir -p $WD
cp -Lr /opt/proxy/letsencrypt/live $WD
rm $WD/README
rm $WD/*/README

# Get numberts from npm-folders
ls $WD | cut -c 5- > /tmp/cert-script/dir_num

# Start variable
i=1
run=true

while [ $run -eq true ]
do
    if grep -q -x -F "$i" "$DIR_NUM"
    then
        cn=$(openssl x509 -in $WD/npm-$i/cert.pem -noout -text | grep "Subject: CN = " | cut -d "=" -f 2 | cut -c 2-)
        date=$(openssl x509 -in $WD/npm-$i/cert.pem -noout -text | grep "Not After :" | cut -d ":" -f 2- | cut -c 2-)
        echo "# Information about $cn" > $WD/npm-$i/README.md
        echo "--------" >> $WD/npm-$i/README.md
        openssl x509 -in $WD/npm-$i/cert.pem -noout -text >> $WD/npm-$i/README.md
        mv $WD/npm-$i $WD/$cn
        i=i+1
        run=true
    else
        run=false
        continue

