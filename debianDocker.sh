#!/bin/bash
apt-get update
apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common htop
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io
docker pull disarmm/matrix
