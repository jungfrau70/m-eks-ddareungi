#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env
helm repo add jahstreet https://jahstreet.github.io/helm-charts
helm repo update

kubectl create ns $NAMESPACE

helm install jahstreet/spark-cluster \
	--name $RELEASE \
	--namespace $NAMESPACE \
        --values values.yaml
