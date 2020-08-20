#!/bin/bash
kubectl -n ingress-nginx delete all --all
kubectl create namespace nginx-ingress

helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo update

helm install stable/nginx-ingress \
       --name nginx-ingress \
       --namespace nginx-ingress \
       --set controller.hostNetwork=true,controller.kind=DaemonSet \
       --set controller.config.proxy-body-size=256m

kubectl patch svc nginx-ingress-controller -n nginx-ingress -p '{"spec": {"type": "LoadBalancer", "externalIPs":["183.111.236.61"]}}'
