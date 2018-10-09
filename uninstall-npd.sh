#!/bin/bash

kubectl delete daemonset/npd-v0.5.0 -n kube-system
kubectl delete ClusterRoleBinding/npd-binding -n kube-system
kubectl delete serviceaccount/node-problem-detector -n kube-system

kubectl delete configmap/npd-config -n kube-system
kubectl delete configmap/npd-plugin -n kube-system
