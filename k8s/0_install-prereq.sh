#!/bin/bash

kubeadm reset
bash cleanup.sh

apt-mark unhold kubeadm kubelet kubectl
apt remove kubeadm kubelet kubectl
#apt install kubeadm=1.17.0-00 kubelet=1.17.0-00 kubectl=1.17.0-00
apt install kubeadm=1.14.8-00 kubelet=1.14.8-00 kubectl=1.14.8-00
apt list kubeadm kubelet kubectl
apt-mark hold kubeadm kubelet kubectl
