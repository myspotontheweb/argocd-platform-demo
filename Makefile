
.PHONY: provision-cluster deploy-argocd deploy-ingress clean

all:

provision-cluster:
	k3d cluster create my-cluster --api-port 6443 -p 8080:80@loadbalancer --agents 2

deploy-argocd:
	helm upgrade --install argo-cd argo-cd --repo https://argoproj.github.io/argo-helm --version 6.7.9 -n argocd --create-namespace --set configs.params."server\.insecure"=true --set configs.params."server\.rootpath"=/argocd

deploy-ingress:
	kubectl create ingress argocd --class=traefik --rule=/argocd*=argo-cd-argocd-server:80 --annotation ingress.kubernetes.io/ssl-redirect=false -n argocd

clean:
	k3d cluster delete my-cluster