#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

cd chart
helm install $RELEASE jupyterhub/binderhub \
  --namespace $NAMESPACE  \
  --version 0.2.0-n130.hc693dc5	\
  --values values.yaml
  #--values config.yaml \
  #-f secret.yaml 
  #--version 0.2.0-n132.h1a8ce62 \
