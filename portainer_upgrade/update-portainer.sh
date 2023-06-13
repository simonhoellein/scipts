#!/bin/bash

# script by sh

upgrade_portainer () {
    echo "stopping container: "
    docker stop portainer
    echo ""
    echo "removing deployment:"
    docker rm portainer
    echo ""
    echo "pulling immage portainer/portainer-ee:latest"
    docker pull portainer/portainer-ee:latest
    echo ""
    echo "starting portainer-ee"
    docker run -d -p 8000:8000 -p 9443:9443 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ee:latest
}

upgrade_portainer_agent () {
    echo "stopping container:"
    docker stop portainer_agent
    echo ""
    echo "removing deployment:"
    docker rm portainer_agent
    echo ""
    echo "pulling image portainer/agent:latest"
    docker pull portainer/agent:latest
    echo ""
    echo "starting portainer-agent"
    docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest
}

echo "# script by sh"
echo "#"
sleep 1
echo "# update Portainer installation"
sleep 1
echo "# ......."
echo "# Choose: "
echo "# "
echo "# 1: Upgrade Portainer"
echo "# 2: Upgrade Portainer-Agent"
read -p "# [1-2] " -n 1
if [[ $REPLY =~ ^[1]$ ]]
    then
        upgrade_portainer
    else
        upgrade_portainer_agent
    fi

echo "# Portainer is up-to-date!"
