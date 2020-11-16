#!/bin/bash

# Run a command in the background.
#_evalBg() {
#    #eval "$@" &>/dev/null & disown;
#    eval "$@" & disown -h;
#}
#
cmd="ngrok http http://183.111.236.104";
#
#_evalBg "${cmd}";


${cmd};
# do below manually
# Ctrl + Z; bg; disown -h;

# default userid & password
#userid: admin@kubeflow.org
#pasword: 12341234
