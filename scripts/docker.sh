#!/usr/bin/env bash

echo "Install docker"

yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce

usermod -aG docker vagrant

systemctl enable docker
systemctl restart docker
