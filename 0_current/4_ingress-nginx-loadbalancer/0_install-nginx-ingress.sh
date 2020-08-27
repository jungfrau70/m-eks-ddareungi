#!/bin/bash

source ./.env
kubectl patch svc default-http-backend -n ingress-nginx -p '{"spec": {"type": "LoadBalancer", "externalIPs":["183.111.236.61"]}}'
