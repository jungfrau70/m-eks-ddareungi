#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

#helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com
#helm repo update

kubectl create ns $NAMESPACE

cd chart
helm install --name $RELEASE . \
  --namespace $NAMESPACE \
  --version 0.14.0 \
  --wait \
  --set credentials.admin="admin" \
  --set credentials.standby="standby" \
  --set credentials.superuser="superuser" \
  --set replicaCount="2" \
  --values values.yaml

kubectl apply -f ../istio-patroni.yaml 
