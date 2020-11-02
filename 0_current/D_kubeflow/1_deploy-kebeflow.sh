#!/bin/bash
# Suggested values: advanced users of Kubernetes and Helm should feel
# free to use different values.
source ./.env

kfctl apply -V -f ${CONFIG_FILE}
