#!/bin/bash

source .env

cd ${KF_DIR}
kfctl delete -f kfctl_aws.yaml
