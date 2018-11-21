#!/usr/bin/env bash

systemctl disable firewalld

echo 'IP tables'
iptables -t nat -F
iptables -F
iptables -X

echo 'Net modules'
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1

echo "Loading kernel modules"
modprobe ip_vs
modprobe ip_vs_rr
modprobe ip_vs_wrr
modprobe ip_vs_sh
modprobe br_netfilter

swapoff -a
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables

if [ ! -f /usr/bin/kubectl ]; then
  echo 'Installing kubernetes'
  yum install -y kubelet kubectl kubeadm

  systemctl daemon-reload
  systemctl enable kubelet
  systemctl restart kubelet
fi
