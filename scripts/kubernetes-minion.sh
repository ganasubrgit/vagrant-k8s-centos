#!/usr/bin/env bash

systemctl daemon-reload
systemctl restart kubelet

echo "Reset kubeadm"
yes | kubeadm reset

echo "Join kubernetes cluster"
kubeadm join master:6443 --token abcdef.0123456789abcdef --discovery-token-unsafe-skip-ca-verification
