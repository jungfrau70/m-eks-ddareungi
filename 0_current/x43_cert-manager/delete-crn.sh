#!/bin/bash
kubectl -n cert-manager delete clusterrole cert-manager-cainjector
kubectl -n cert-manager delete clusterrole cert-manager-controller-issuers
kubectl -n cert-manager delete clusterrole cert-manager-controller-clusterissuers
kubectl -n cert-manager delete clusterrole cert-manager-controller-certificates
kubectl -n cert-manager delete clusterrole cert-manager-controller-orders
kubectl -n cert-manager delete clusterrole cert-manager-controller-challenges
kubectl -n cert-manager delete clusterrole cert-manager-controller-ingress-shim
kubectl -n cert-manager delete clusterrolebinding cert-manager-cainjector
kubectl -n cert-manager delete clusterrolebinding cert-manager-controller-issuers
kubectl -n cert-manager delete clusterrolebinding cert-manager-controller-clusterissuers
kubectl -n cert-manager delete clusterrolebinding cert-manager-controller-certificates
kubectl -n cert-manager delete clusterrolebinding cert-manager-controller-orders
kubectl -n cert-manager delete clusterrolebinding cert-manager-controller-challenges
kubectl -n cert-manager delete clusterrolebinding cert-manager-controller-ingress-shim
kubectl -n cert-manager delete MutatingWebhookConfiguration cert-manager-webhook
kubectl -n cert-manager delete ValidatingWebhookConfiguration cert-manager-webhook

