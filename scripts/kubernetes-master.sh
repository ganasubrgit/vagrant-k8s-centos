#!/usr/bin/env bash

# Installing kubernetes admin if bin does not exist
systemctl daemon-reload
systemctl restart kubelet

if ! kubeadm token list | grep abcdef.0123456789abcdef ; then
  echo "Run kubeadm init"
  kubeadm init --token=abcdef.0123456789abcdef --apiserver-advertise-address=$(hostname -i) --pod-network-cidr=10.244.0.0/16

  mkdir -p $HOME/.kube
  cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  chown $(id -u):$(id -g) $HOME/.kube/config

  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
fi

export KUBECONFIG=/etc/kubernetes/admin.conf
