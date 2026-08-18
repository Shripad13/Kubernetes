# HELM - Package Manager for k8s

1. Using Helm install k8s contorller, 3rd party applications - install, update, uninstall.
2. Why Helm - They might have to create script for each k8s contoller and also for multiple versions of k8s conroller.
 Even for UAT, Prod, Stgaing you can craete a helm chart

3. How to Install Helm - 
Search for install Helm- go to official documentation, Run the commands

Do I need to install anything on K8s cluster?
V2 of Helm - Had to install tiller
V3 of Helm - no need to install anything on k8s cluster

> helm version      --> Check Helm Version

 $ kubectl config list --> Shows k8s clusters
 $ kind get clusters   --> Shows k8s clusters
 $ kubectl config current-context  --> 

 
 CHART is a bundle of applications like prometheus, garfana,

 helm repo add bitnami https://charts.bitnami.com/bitnami - HAS MOST OF THE POPULAR CHARTS, use this repo on k8s cluster.
 $ helm repo add bitnami https://charts.bitnami.com/bitnami
 $ helm search repo bitnami
 $ helm search repo bitnami |grep nginx
 $ helm install ReleaseName bitnami/<chart>
 $ helm install NginxV1 bitnami/nginx
 $ kubectl get pods ---> you will get nginx pod
 $ helm uninstall NginxV1   (Provide release name)
 


# Install AWS Load Balancer Controller : In AWS documentation you get below command
 $ helm repo add eks https://aws.github.io/eks-charts
 $ helm repo update eks
 $ helm search repo eks| grep load
 $ helm install alb eks/aws-load-balancer-controller

 $ helm relpo index . 