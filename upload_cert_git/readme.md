# Upload SSL-Certificates to Git

## Use case
This script is designt to upload SSL-Certificates from the [nginx proxy manager](https://github.com/NginxProxyManager/nginx-proxy-manager) to Git. This comes in handy if you want to use the certs on other systems without issuing certs for every system.

## Features
* Detects certificates and copy them to a working-directory to not interrupt production workloads
* Renames certificates from npm-id to the domain-name
* creates a readme file with cert-information
* uploads certs to Git

## Modifications you need to do:
* modify the Readme file to your needs if you need it
* change the Paths from npm-data, script-location, working directory and git-folder
* create a git repo where the certs should be published and clone it