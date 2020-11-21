#!/bin/bash

watch -n 1 kubectl -n auth get ing,svc,po,ep
