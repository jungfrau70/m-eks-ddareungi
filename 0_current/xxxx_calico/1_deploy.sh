#!/bin/bash

kubectl apply -f  https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml
sed s/192.168.0.0\\/16/10.96.0.0\\/12/g -i calico.yaml
kubectl apply -f calico.yaml
