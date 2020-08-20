#!/bin/bash
source ./.env

helm delete $CD_RELEASE --purge

