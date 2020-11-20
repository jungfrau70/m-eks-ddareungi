#!/bin/bash

kubectl create configmap dex --from-file=config.yaml=dex-config-final.yaml -n auth --dry-run -oyaml | kubectl apply -f -
