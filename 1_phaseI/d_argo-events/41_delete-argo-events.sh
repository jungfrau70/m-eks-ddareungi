#!/bin/bash
source ./.env

helm delete $EVENTS_RELEASE --purge

