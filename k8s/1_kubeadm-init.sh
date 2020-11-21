#!/bin/bash

#kubeadm init
#kubeadm init --pod-network-cidr=192.168.0.0/16   # Calico
kubeadm init --pod-network-cidr=10.217.0.0/16    # Cilium
#kubeadm init --pod-network-cidr=10.244.0.0/16    # Flannel
