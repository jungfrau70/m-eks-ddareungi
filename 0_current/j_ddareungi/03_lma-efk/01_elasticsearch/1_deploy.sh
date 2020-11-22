#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

#helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add elastic https://helm.elastic.co
helm repo update

helm install $RELEASE elastic/elasticsearch \
	--namespace=$NAMESPACE \
	--set version=7.9.3
