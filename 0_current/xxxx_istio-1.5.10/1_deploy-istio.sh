#!/bin/bash

#sudo apt update && sudo apt upgrade -y
#sudo apt-get install nfs-kernel-server nfs-common -y
#sudo mkdir -p /data/kubedata
#sudo chown 777 /data/kubedata
#sudo vi /etc/exports
#sudo exportfs -rav
source ./.env

helm install install/kubernetes/helm/istio \
       --name $RELEASE \
       --namespace $NAMESPACE \
       --values install/kubernetes/helm/istio/values-istio-demo.yaml
