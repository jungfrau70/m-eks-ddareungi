#!/bin/bash
source ./.env

helm delete $RELEASE --purge


cd istio-1.5.2
helm template install/kubernetes/helm/istio --name istio --namespace istio-system \
    --values install/kubernetes/helm/istio/values-istio-demo.yaml | kubectl delete -f -

