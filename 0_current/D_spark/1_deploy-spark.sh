#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

helm install $RELEASE bitnami/spark \
	--namespace $NAMESPACE \
        --values values.yaml
