#!/bin/bash

#sudo apt update && sudo apt upgrade -y
#sudo apt-get install nfs-kernel-server nfs-common -y
#sudo mkdir -p /data/kubedata
#sudo chown 777 /data/kubedata
#sudo vi /etc/exports
#sudo exportfs -rav

helm install --name nfs-client stable/nfs-client-provisioner --namespace kube-system --set nfs.server=192.168.1.232 --set nfs.path=/data/kubedata
kubectl patch storageclass nfs-client -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
