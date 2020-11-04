#!/bin/bash
kubectl apply -f nginx-letsencrypt-staging.yaml
kubectl apply -f nginx-letsencrypt-prod.yaml
