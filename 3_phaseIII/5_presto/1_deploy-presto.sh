#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

#helm repo add elastic https://helm.elastic.co
#helm repo update

kubectl create ns $NAMESPACE

helm install $CHART \
  --name $RELEASE \
  --namespace $NAMESPACE
