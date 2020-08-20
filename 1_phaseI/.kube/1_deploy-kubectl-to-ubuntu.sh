#!/bin/bash
rm -rf /home/ubuntu/.kube
cp -R /root/.kube /home/ubuntu/.kube
sudo chown -R ubuntu:ubuntu /home/ubuntu/.kube
kubectl taint nodes 192.168.1.232 key=value:NoSchedule
