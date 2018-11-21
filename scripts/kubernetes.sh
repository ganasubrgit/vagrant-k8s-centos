#!/usr/bin/env bash

systemctl disable firewalld

echo 'IP tables'
iptables -t nat -F
iptables -F
iptables -X

sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.bridge.bridge-nf-call-iptables=1

echo 'Delete the docker bridge'
ip link set docker0 down
ip link delete docker0

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
