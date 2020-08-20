#!/bin/bash
VERSION=1.0.0
docker build -t binderhubonline/ds-blog:$VERSION .
docker push binderhubonline/ds-blog:$VERSION
