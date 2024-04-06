# argocd-platform-demo

## Description

## Getting started

### Dependencies

System dependencies

* [Docker](https://docs.docker.com/engine/install/ubuntu/)

Install the following tools using [arkade](https://github.com/alexellis/arkade)

```
ark get kubectl kubectx kubens helm k3d argocd
```

### Installation

Bootstrap the K8s cluster(s)

```
./bootstrap/k3d/run.sh
```

Deploy services to the cluster

```
#
# Login
#
kubens argocd
argocd login --core

#
# Create the bootstrap application
#
argocd app create bootstrap-services \
  --repo https://github.com/myspotontheweb/argocd-platform-demo.git \
  --path services \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace argocd \
  --sync-policy automated
```

### Execution

## Help

## Version History