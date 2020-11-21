#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.

rm -rf .ca* ku*
./kfctl apply -V -f kfctl_istio_dex.v1.1.0.yaml
