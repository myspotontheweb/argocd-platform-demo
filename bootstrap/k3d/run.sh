#!/bin/bash

set -euo pipefail

BASE_DIR=$(dirname $0)
ARGOCD_VERSION=6.7.9

#
# Create management cluster
#
k3d cluster create --config $BASE_DIR/config/management.yaml

#
# Install ArgoCD + configure an ingress to expose without tls
#
helm upgrade --install argo-cd argo-cd --repo https://argoproj.github.io/argo-helm --version $ARGOCD_VERSION -n argocd --create-namespace --set configs.params."server\.insecure"=true --set configs.params."server\.rootpath"=/argocd --wait
kubectl create ingress argocd --class=traefik --rule=/argocd*=argo-cd-argocd-server:80 --annotation ingress.kubernetes.io/ssl-redirect=false -n argocd

#
# Bootstrap platform services
#
kubectl apply -f $BASE_DIR/../manifests/

#
# Create tenant cluster(s)
#
k3d cluster create --config $BASE_DIR/config/tenant1-nonprod.yaml --kubeconfig-switch-context=false

#
# Add tenant clusters(s)
#
kubens argocd
argocd login --core
argocd cluster add k3d-tenant1-nonprod --name tenant1-nonprod --yes

#
# Print login details
#
kubectl get secret argocd-initial-admin-secret -n argocd  -ogo-template='{{printf "\nurl: http://localhost:8080/argocd\nuser: admin\npass: %s\n" (.data.password|base64decode)}}'
