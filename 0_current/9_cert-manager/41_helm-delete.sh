#!/bin/bash

source ./.env

helm delete $RELEASE -n $NAMESPACE

kubectl get crd | grep -i cert-manager | kubectl delete crd `awk '{print $1}'`
kubectl get clusterrole | grep -i cert-manager | kubectl delete clusterrole `awk '{print $1}'`
kubectl get clusterrolebinding | grep -i cert-manager | kubectl delete clusterrolebinding `awk '{print $1}'`
kubectl get MutatingWebhookConfiguration | grep -i cert-manager | kubectl delete MutatingWebhookConfiguration `awk '{print $1}'`
kubectl get ValidatingWebhookConfiguration | grep -i cert-manager | kubectl delete ValidatingWebhookConfiguration `awk '{print $1}'`

