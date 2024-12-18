# Create an EKS cluster

How to launch an AWS EKS cluster for working on this  demo

# Usage

## Generate cluster configuration (Optional)

```
eksctl create cluster --name default-fargate --version 1.31 --region eu-west-1 --fargate --dry-run | yq '.addonsConfig.autoApplyPodIdentityAssociations=true' > bootstrap/eks/config/default.yaml
```

Note:

* Applied the work-around detailed here: [#8035](https://github.com/eksctl-io/eksctl/issues/8035)

## Launch cluster

```
export AWS_ACCESS_KEY_ID="XXXXXXXXXXXXXXXXXXXX"
export AWS_SECRET_ACCESS_KEY="YYYYYYYYYYYYYYYYYYYY"
export AWS_SESSION_TOKEN="ZZZZZZZZZZZZZZZZZZZZ"
export AWS_REGION="eu-west-1"

./bootstrap/eks/run.sh
```

# Miscellaneous

## Required software

aws

```
#
# Install
#
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

#
# Upgrade
#
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
```

eksctl 

```
# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo mv /tmp/eksctl /usr/local/bin
```

kubectl

```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
```

helm

```
curl -LO https://get.helm.sh/helm-v3.16.3-linux-amd64.tar.gz
tar zxvf helm-v3.16.3-linux-amd64.tar.gz
sudo install -o root -g root -m 0755 linux-amd64/helm /usr/local/bin/helm
helm version
```

yq

```
curl -LO https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
sudo install -o root -g root -m 0755 yq_linux_amd64 /usr/local/bin/yq
```