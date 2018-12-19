#!/usr/bin/env bash

# Installing docker if bin does not exist
if [ ! -f /usr/bin/docker ]; then
  echo "Installing docker"
  yum install -y yum-utils device-mapper-persistent-data lvm2
  yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  yum -y install docker-ce-18.06.1.ce-3.el7

  usermod -aG docker root
  usermod -aG docker vagrant

  systemctl enable docker
  systemctl restart docker
fi
