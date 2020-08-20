#!/bin/bash
VERSION=1.0.3
cd server
docker build -t binderhubonline/server:$VERSION .
docker push binderhubonline/server:$VERSION
