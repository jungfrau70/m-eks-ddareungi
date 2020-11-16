#!/bin/bash
source ./.env

#kubectl -n kubeflow delete all --all
#kubectl -n istio-system delete all --all
#kubectl -n knative-serving delete all --all
kfctl delete -V -f ${CONFIG_FILE}
