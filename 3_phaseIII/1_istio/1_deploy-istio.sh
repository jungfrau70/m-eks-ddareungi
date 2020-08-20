#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

##################################################
### https://istio.io/docs/setup/install/helm/
##################################################

helm repo add istio.io https://storage.googleapis.com/istio-release/releases/1.5.2/charts/
helm repo update

cd istio-1.5.2
kubectl create ns $NAMESPACE
helm template install/kubernetes/helm/istio-init --name istio-init --namespace istio-system | kubectl apply -f -
kubectl -n istio-system wait --for=condition=complete job --all

helm template install/kubernetes/helm/istio --name istio --namespace istio-system \
    --values install/kubernetes/helm/istio/values-istio-demo.yaml | kubectl apply -f -
