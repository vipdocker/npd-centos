#!/bin/bash

# init config files into configmap

kubectl create configmap npd-config --from-file=./config -n kube-system

