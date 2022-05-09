#!/bin/bash

#################
# Cert-Uploader #
#################

# Explenation: This Script is ment to upload Certificates from NGINX Proxy Manager to a Gitlab Repository

# Global Vars
WD=/tmp/cert-script/live
DIR_NUM=/tmp/cert-script/dir_num

# Copy Certfiles to Work-Directory and rm all README files
mkdir -p $WD
cp -Lr /opt/proxy/letsencrypt/live /tmp/cert-script/
find /tmp/cert-script/live -type f -name 'README' -delete

# Get numberts from npm-folders
ls $WD | cut -c 5- > /tmp/cert-script/dir_num

# Start variable
i=1
e=$(cat $DIR_NUM | wc -l)
e=$((e+1))

while [ $i -le $e ]
do
    if grep -q -x -F "$i" "$DIR_NUM"
    then
        cn=$(openssl x509 -in $WD/npm-$i/cert.pem -noout -text | grep "Subject: CN = " | cut -d "=" -f 2 | cut -c 2-)
        exp_date=$(openssl x509 -in $WD/npm-$i/cert.pem -noout -text | grep "Not After :" | cut -d ":" -f 2- | cut -c 2-)
        echo "# Information about $cn" > $WD/npm-$i/README.md
        echo "--------" >> $WD/npm-$i/README.md
        openssl x509 -in $WD/npm-$i/cert.pem -noout -text >> $WD/npm-$i/README.md
        mv $WD/npm-$i $WD/$cn
        i=$((i+1))
    else
        i=$((i+1))
    fi
done

# upload to git

mv /tmp/cert-script/live/ /root/cert
rm $DIR_NUM

cd /root/cert
git commit -m certificate update
git push