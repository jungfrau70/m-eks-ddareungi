#!/bin/bash
rm -rf /home/ubuntu/.kube
mkdir -p /home/ubuntu/.kube
cp kube_config_cluster.yml ~/.kube
cp -R /root/.kube/kube_config_cluster.yml /home/ubuntu/.kube
sudo chown -R ubuntu:ubuntu /home/ubuntu/.kube
kubectl taint nodes 192.168.1.232 key=value:NoSchedule
