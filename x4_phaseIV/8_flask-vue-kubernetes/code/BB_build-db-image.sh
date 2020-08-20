#!/bin/bash
VERSION=1.0.0
cd db
docker build -t binderhubonline/db:$VERSION .
docker push binderhubonline/db:$VERSION
