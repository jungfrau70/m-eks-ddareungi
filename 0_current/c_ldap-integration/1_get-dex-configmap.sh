#!/bin/bash

kubectl get configmap dex -n auth -o jsonpath='{.data.config\.yaml}' > dex-config.yaml
