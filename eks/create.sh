git pull
terraform init
sleep 5
terraform plan
sleep 15
terraform apply -auto-approve

# Installing metrics server 
aws eks update-kubeconfig --name ClusterName
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml


kubectl create namespace argocd && true 
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml