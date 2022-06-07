#!/bin/bash

#################
# Cert-Uploader #
#################

# Explenation: This Script is ment to upload Certificates from NGINX Proxy Manager to a Gitlab Repository

# Global Vars
WD=/tmp/cert-script/live
DIR_NUM=/tmp/cert-script/dir_num
README=/root/cert/README.md
SCRIPT_LOCATION=/root/scripts/upload_cert_git

# Intro-Text
echo "_________                __  .__  _____.__               __                 "
echo "\_   ___ \  ____________/  |_|__|/ ____\__| ____ _____ _/  |_  ____   ______"
echo "/    \  \/_/ __ \_  __ \   __\  \   __\|  |/ ___\\__  \\   __\/ __ \ /  ___/"
echo "\     \___\  ___/|  | \/|  | |  ||  |  |  \  \___ / __ \|  | \  ___/ \___ \ "
echo " \______  /\___  >__|   |__| |__||__|  |__|\___  >____  /__|  \___  >____  >"
echo "        \/     \/                              \/     \/          \/     \/ "
echo ""
echo "# Script by sh"
echo ""
echo "# Explenation: This Script is ment to upload Certificates from NGINX Proxy Manager to a Gitlab Repository"
echo ""
echo "Working Directory: $WD"
echo "Directory-Numbers: $DIR_NUM"
echo ""
sleep 2
# Copy Certfiles to Work-Directory and rm all README files
echo ""
echo "###############################################################################"
echo "# Copying files to Working Directory                                          #"
echo "###############################################################################"
echo ""
sleep 2
mkdir -p $WD

# Copy files to Temp-Dir, follow symlinks
cp -Lrv /opt/proxy/letsencrypt/live /tmp/cert-script/
echo ""
echo "###############################################################################"
echo "# Delete all README Files in Cert-Directory                                   #"
echo "###############################################################################"
echo ""
sleep 1
find /tmp/cert-script/live -type f -name 'README' -delete -print

# README-File for Cert-Repo
echo ""
echo "###############################################################################"
echo "# Prepeare README File for Git-Repo                                           #"
echo "###############################################################################"
echo ""
echo "README-File: $README"
echo "Script-Location: $SCRIPT_LOCATION"
cat $SCRIPT_LOCATION/helper.preset-readme.md > $README

# Get numberts from npm-folders
ls $WD | cut -c 5- > /tmp/cert-script/dir_num

# Start variable
i=1 #incremental Stepup by one
e=$(cat $DIR_NUM | wc -l) #highest folder number
e=$((e+1))

echo ""
echo "###############################################################################"
echo "# Get Certificates                                                            #"
echo "###############################################################################"
echo ""
#Rename Algorythmus
while [ $i -le $e ]
do
    if grep -q -x -F "$i" "$DIR_NUM"
    then
        cn=$(openssl x509 -in $WD/npm-$i/cert.pem -noout -text | grep "Subject: CN = " | cut -d "=" -f 2 | cut -c 2-)
        exp_date=$(openssl x509 -in $WD/npm-$i/cert.pem -noout -text | grep "Not After :" | cut -d ":" -f 2- | cut -c 2-)
        val_date=$(openssl x509 -in $WD/npm-$i/cert.pem -text -noout | grep "Not Before:" | cut -d ":" -f 2- | cut -c 2-)
        date=$(date)
        echo "|$cn|$exp_date|$val_date|$date|" >> $README
        echo "# Information about $cn" > $WD/npm-$i/README.md
        echo "--------" >> $WD/npm-$i/README.md
        echo "Experiation Date:" $exp_date >> $WD/npm-$i/README.md
        echo "## Other Information: " >> $WD/npm-$i/README.md
        echo "````" >> $WD/npm-$i/README.md
        openssl x509 -in $WD/npm-$i/cert.pem -noout -text >> $WD/npm-$i/README.md
        echo "````" >> $WD/npm-$i/README.md
        mv $WD/npm-$i $WD/$cn
        echo "Certificate Nr. $i"
        echo "======"
        echo "CN = $cn"
        echo "Experiation = $exp_date"
        echo "Renewed at  = $val_date"
        echo "Updated = $date"
        echo ""
        sleep 1
        i=$((i+1))
    else
        i=$((i+1))
    fi
done

# upload to git
echo ""
echo "###############################################################################"
echo "# Copy certificate to upload directory                                        #"
echo "###############################################################################"
echo ""
cp -rv /tmp/cert-script/live/* /root/cert
rm -rv /tmp/cert-script/live
rm $DIR_NUM
echo ""
echo "###############################################################################"
echo "# push to Gitlab                                                              #"
echo "###############################################################################"
echo ""
cd /root/cert
git pull
git add *
git commit -m "certificate update"
git push

# healcheck ping
curl -fsS --retry 5 https://hc-ping.com/4f6a585c-fb0a-4a24-893e-504c442209df


# sed -i [line:$l] [input: |'$CN'|'$EXP_DATE'|] /root/cert/README.md
# l=$((l+1))
