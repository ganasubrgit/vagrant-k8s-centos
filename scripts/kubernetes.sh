#!/usr/bin/env bash

systemctl disable firewalld

iptables -t nat -F
iptables -F
iptables -X

swapoff -a
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables

if [ ! -f /usr/bin/kubectl ]; then
  echo 'Installing kubernetes'
  yum install -y kubelet kubectl kubeadm

  systemctl daemon-reload
  systemctl enable kubelet
  systemctl restart kubelet
fi
