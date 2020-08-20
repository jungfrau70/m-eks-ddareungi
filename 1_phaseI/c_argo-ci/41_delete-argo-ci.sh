#!/bin/bash
source ./.env

helm delete $CI_RELEASE --purge

