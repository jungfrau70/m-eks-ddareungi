#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.

./kfctl delete -V -f kfctl_istio_dex.v1.2.0.yaml
