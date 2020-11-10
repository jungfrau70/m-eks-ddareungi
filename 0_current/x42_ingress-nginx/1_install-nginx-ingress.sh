#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

#helm repo add stable https://kubernetes-charts.storage.googleapis.com/
#helm repo update

cd chart
helm install nginx-ingress . \
       --namespace $NAMESPACE \
       --set controller.hostNetwork=true,controller.kind=DaemonSet \
       --set controller.config.proxy-body-size=256m \
       --values values.yaml

#kubectl patch svc nginx-ingress-controller -n nginx-ingress -p '{"spec": {"type": "LoadBalancer", "externalIPs":["183.111.236.61"]}}'
