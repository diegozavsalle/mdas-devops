#### list nodes
$ kubectl get nodes
#### list namespaces
$ kubectl get namespaces
#### create namespace
$ kubectl create ns mdas-software-tools
#### delete namespace
$ kubectl delete ns mdas-software-tools

#### change default context
$ kubectl config set-context --namespace mdas-software-tools
<!-- check -->
$ kubectl config get-contexts

#### create pod specifyng namespace
$ kubectl run pod-nginx-diego --generator=run-pod/v1 --image=nginx --namespace mdas-software-tools

get info about pod
#### $ kubectl describe pod pod-nginx-diego

### 
### POD: puedes ejecutar varios containers dentro,<br> similar a una máquina virtual
- Se comparte interfaz de red dentro de un POD
- 


####    
$ kubectl run tools --generator=run-pod/v1 -it --rm --image=paulopez/kurl -- bash

$ kubectl expose pod pod-nginx-diego --port=80 --target-port=80 --type NodePort


### for pipeline
kubectl apply -f votingapp.yaml



### final.. usando pots en archivos yaml
### get deployments
kubectl get deployments