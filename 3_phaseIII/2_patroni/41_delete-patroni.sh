#!/bin/bash
source ./.env

helm delete $RELEASE --purge

kubectl delete -f istio-patroni.yaml
