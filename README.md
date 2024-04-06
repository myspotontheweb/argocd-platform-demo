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

Login using CLI

```
kubens argocd
argocd login --core
```

```
argocd app create bootstrap-services \
   --repo https://github.com/myspotontheweb/argocd-platform-demo.git \
   --path services \
   --dest-namespace argocd \
   --dest-server https://kubernetes.default.svc \
   --sync-policy automated
```

### Execution

## Help

## Version History