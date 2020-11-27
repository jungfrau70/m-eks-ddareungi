#!/bin/bash

source .env

cd ${KF_DIR}
kfctl apply -f kfctl_aws.yaml
