#!/bin/bash

watch kubectl get po,svc,ing -A -o wide
