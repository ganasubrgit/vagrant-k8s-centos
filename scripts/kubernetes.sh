#!/usr/bin/env bash

echo 'Install kubernetes'
swapoff -a
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables

yum install -y kubelet kubeadm kubectl

export KUBECONFIG=/etc/kubernetes/admin.conf

systemctl enable kubelet
systemctl restart kubelet
