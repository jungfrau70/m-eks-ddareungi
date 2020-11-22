#!/bin/bash
source ./.env

kubectl get namespace $NAMESPACE &> /dev/null || kubectl create namespace $NAMESPACE

helm repo add elastic https://helm.elastic.co
helm repo update

helm install $RELEASE elastic/kibana \
	--namespace=$NAMESPACE \
	--set version=7.9.3
