#!/usr/bin/env bash

echo "Coping static files"
cp config/hosts /etc/hosts
cp config/resolv.conf /etc/resolv.conf
cp config/k8s.conf /etc/sysctl.d/k8s.conf
cp config/kubernetes.repo /etc/yum.repos.d/kubernetes.repo
