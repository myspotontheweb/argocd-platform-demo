#!/bin/bash

set -euo pipefail

BASE_DIR=$(dirname $0)
PILOT_CONTEXT=k3d-pilot-cluster
ARGOCD_VERSION=6.7.9

#
# Create cluster(s)
#
k3d cluster create --config $BASE_DIR/config/pilot-cluster.yaml

#
# Install ArgoCD
#
helm --kube-context $PILOT_CONTEXT upgrade --install argo-cd argo-cd --repo https://argoproj.github.io/argo-helm --version $ARGOCD_VERSION -n argocd --create-namespace --set configs.params."server\.insecure"=true --set configs.params."server\.rootpath"=/argocd --wait
kubectl --context $PILOT_CONTEXT create ingress argocd  --class=traefik --rule=/argocd*=argo-cd-argocd-server:80 --annotation ingress.kubernetes.io/ssl-redirect=false -n argocd

#
# Print login details
#
kubectl --context $PILOT_CONTEXT get secret argocd-initial-admin-secret -n argocd  -ogo-template='{{printf "\nurl: http://localhost:8080/argocd\nuser: admin\npass: %s\n" (.data.password|base64decode)}}'
kubectl --context $PILOT_CONTEXT get secret argocd-initial-admin-secret -n argocd  -ogo-template='{{printf "\nargocd login http://localhost:8080/argocd --username admin --password %s\n" (.data.password|base64decode)}}'
