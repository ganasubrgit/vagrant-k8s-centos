#!/usr/bin/env bash

echo "Reset services"
systemctl daemon-reload
systemctl restart kubelet

echo "Reset kubeadm"
yes | kubeadm reset

echo "Run kubeadm init"
kubeadm init --token=abcdef.0123456789abcdef --apiserver-advertise-address=$(hostname -i) --pod-network-cidr=10.244.0.0/16

echo "Copy /etc/kubernetes/admin.conf"
mkdir -p /home/vagrant/.kube
yes | cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown vagrant:vagrant /home/vagrant/.kube/config

export KUBECONFIG=/home/vagrant/.kube/config

echo "Set cni networking"
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
