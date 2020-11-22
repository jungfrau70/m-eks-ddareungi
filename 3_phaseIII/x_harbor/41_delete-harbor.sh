#!/bin/bash
source ./.env

helm delete $RELEASE -n $NAMESPACE

kubectl delete -f istio-harbor.yaml
