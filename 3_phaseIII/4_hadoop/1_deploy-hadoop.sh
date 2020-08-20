#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

#helm repo add elastic https://helm.elastic.co
#helm repo update

kubectl create ns $NAMESPACE

cd hadoop-helm
#helm install $(hadoop-helm/tools/calc_resources.sh 50) . \
helm install  . \
  --name $RELEASE \
  --namespace $NAMESPACE
  --values values.yaml
