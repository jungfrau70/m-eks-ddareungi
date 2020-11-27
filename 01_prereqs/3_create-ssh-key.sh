#!/bin/bash
# https://www.eksworkshop.com/020_prerequisites/sshkey/
ssh-keygen
aws ec2 import-key-pair --key-name "eks" --public-key-material file://~/.ssh/id_rsa.pub
