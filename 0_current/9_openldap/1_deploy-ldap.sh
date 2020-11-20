#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

helm repo add stable https://charts.helm.sh/stable
helm repo update

cd chart
helm install $RELEASE stable/openldap \
     --namespace $NAMESPACE \
     --values values.yaml
