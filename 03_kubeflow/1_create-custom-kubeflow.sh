#!/bin/bash

source .env

mkdir -p ${KF_DIR}
cd ${KF_DIR}

wget -O kfctl_aws.yaml $CONFIG_URI

sed -i '/region: us-west-2/ a \      enablePodIamPolicy: true' ${CONFIG_FILE}

sed -i -e 's/kubeflow-aws/'"$AWS_CLUSTER_NAME"'/' ${CONFIG_FILE}

sed -i "s@us-west-2@$AWS_REGION@" ${CONFIG_FILE}


sed -i "s@roles:@#roles:@" ${CONFIG_FILE}
#ROLE_NAME=$(eksctl get fargateprofile --cluster $AWS_CLUSTER_NAME -o json | jq -r '.[].podExecutionRoleARN')
sed -i "s@- eksctl-fargate-nodegroup-ng-a2-NodeInstanceRole-xxxxxxx@#- eksctl-fargate-cluster-FargatePodExecutionRole-1VCYZWHBUVK46@" ${CONFIG_FILE}

curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator
chmod +x aws-iam-authenticator
sudo mv aws-iam-authenticator /usr/local/bin

aws iam list-roles \
    | jq -r ".Roles[] \
    | select(.RoleName \
    | startswith(\"eksctl-$AWS_CLUSTER_NAME\") and contains(\"NodeInstanceRole\")) \
    .RoleName"
