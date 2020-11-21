#/bin/bash
source ./.env

watch kubectl get po,svc,ing -n kubeflow;istio-system
