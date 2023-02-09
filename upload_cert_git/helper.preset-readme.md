# Certificate Store

**Domains in this Respository get updated from `proxy.dmz.shoellein.de`**

> Crontab `0 0 * * *` runs daily at 00:00

<img src=https://healthchecks.io/badge/c7cfa7e6-4207-4122-b4db-87013e/yB4KFHfn/Certificates.svg>

<br>

>The upload-script is located at https://gitlab.shoellein.de/shoellein/scripts/-/blob/main/upload_cert_gitlab.sh

## Script for automatic update

* just change locations from the folder depending on the cert

```sh
#!/bin/bash

cd /root/cert
git pull
cp -rv /root/cert/*.net.shoellein.de/* /etc/letsencrypt/live/net.shoellein.de/
```
* crontab:
```sh
0 0 * * * /root/cert-update.sh > /dev/null 2>&1
```

### Clone with git and ssh-key

1. create a new ssh-keypair using `ssh-keygen` and save it in /root/.ssh/id_rsa
2. upload `id_rsa.pub` to the ssh-keyfile store in gitlab for user `certpull`
3. edit ssh-config

```sh
Host gitlab
        Hostname gitlab.net.shoellein.de
        IdentityFile ~/.ssh/id_rsa.pub
```
4. clone cert-repo with `git clone git@gitlab.net.shoellein.de:shoellein/cert.git`

> its important to use `gitlab.net.shoellein.de` instead of `gitlab.shoellein.de` otherwise clone via ssh would not work!


## Expiration 

|Authorized to|Expiration Date|Valid from|latest Update|
|---|---|---|---|
