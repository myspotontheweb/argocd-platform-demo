# argocd-platform-demo

## Description

## Getting started

### Dependencies

System dependencies

* [Docker](https://docs.docker.com/engine/install/ubuntu/)

Install the following tools using [arkade](https://github.com/alexellis/arkade)

```
ark get yq jq kubectl kubectx kubens helm k9s k3d argocd kubeseal
```

### Installation

Bootstrap the K8s cluster(s)

```
./bootstrap/k3d/run.sh
```

### Execution

### Cleanup

Assuming you used the k3d bootstrap
```
k3d cluster list --no-headers | awk '{printf "k3d cluster delete %s\n",$1}'| bash
```

## Help

## Version History