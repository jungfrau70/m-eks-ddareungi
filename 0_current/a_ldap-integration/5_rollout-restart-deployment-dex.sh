#!/bin/bash

kubectl rollout restart deployment dex -n auth
