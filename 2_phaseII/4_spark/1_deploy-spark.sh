#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

kubectl create ns $NAMESPACE

helm install --name $RELEASE bitnami/spark \
	--namespace $NAMESPACE \
        --values values.yaml
