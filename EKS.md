####

### Managed Services for k8s on AWS:
    
    *EKS: Elastic Kubernetes Service (Very Robust & heavy lifting service)

# Advantage of using EKS:
    1. AWS is responsible for manging the nodes.
    2. You dont have to do Linux Patching, you are not responsible for container runtime management
    3. You dont have to employ storage solutions & you get out of the box HA storage solution.
    4. Very nice features can be installed as optional & we call them plug-ins.

1. In Production based env, we will have multi-based masters approach & those master will be in differnet AZ's.

# what will happen if your master node is gone/down in a k8s cluster?

    1. In managed environment, we dont be having access to MASTER NODE (Its in AWS control, AWS will take care of MASTER nodes)
    2. If master node is down, you cannot schedule new work loads & you cannot connect to the cluster (kube-api server, etcd, scheduler & controller manager are on master)
    3. Existing work loads runs as is (but any of the pods of the deployment were killed then new pods of that controller will not come up)
    4. you can have a  n number of node-groups to a single cluster.
    5. you can have multi-master k8s cluster to achieve HA in case of Master Node failure.


## How to create k8s cluster?
    1. First create the cluster by selecting the version of our choice.
    2 Create the node-pools/ node-groups with the instance type of your choice & these nodes can be SPOT or RESERVED or ON-DEMAND 

node-pool & node-group are both same only.

There will be one Node-pool of On-Demand Instances & one Node-pool of SPOT Instances in k8s cluster.
Cost Saving Strategy for Node-pools - 60% of the nodes are On-Demand & 40% of the nodes are SPOT instances.
Instance type purely depends on work-loads of application.

## In AWS, EKS offers 3 types of clusters w.r.t. to connectivity
1. Public cluster - The Cluster endpoint is  accessible from outside of your VPC, worker node will leave your VPC connect to the endpoint.
2. Public & Private - The Cluster endpoint is  accessible from outside of your VPC, worker node traffic to the endpoint will stay within your VPC.
3. Priavte Cluster (In corporate this will be used strictly) - The Cluster endpoint is only accessible through your VPC, worker node traffic to the endpoint will stay within your VPC.

* What is the networking solution offered on AWS?
1. Amazon VPC CNI: is the networking solution that can be enabled to get pod & service level restriction

* What are the other networking solutions that are supported by k8s?
1. Calico CNI
2. Weavenet CNI

* Amazon GuardDuty EKS Runtime Montioring - Identfies the legitimate requests/ traffic, check for anamolies
* Amazon EKS Pod Identity Agent - Pod can access directly s3, or anyother service without any keys.



## How to connect to an EKS Cluster?

  $ aws eks update-kubeconfig --name clusterName

  

## How to get the Metrics or Saturation Info of the nodes & pods on EKS? 
To gain metrics level information on EKS, we need to have Metrics Server Installed & I would like to do it as part of the cluster provisioning

# For Installing Metrics server - command from AWS EKS to run.
aws eks update-kubeconfig --name ClusterName
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

###### Production Architecture  ######
Internet
    │
Route53
    │
AWS WAF
    │
Application Load Balancer (ALB)
    │
AWS Load Balancer Controller
    │
 Kubernetes Ingress
    │
Kubernetes Services (ClusterIP)
    │
  Pods

> How would you expose a service running in EKS to the public internet in a production-safe way?

In a production EKS environment, I would not expose each application directly using a Kubernetes Service of type LoadBalancer. Instead, I would use an Ingress Controller with AWS Application Load Balancer (ALB).

1. Deploy AWS Load Balancer Controller
Create IAM policy:
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json

aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam_policy.json

Create Service Account using IRSA:
eksctl create iamserviceaccount \
  --cluster my-eks-cluster \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --attach-policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve

Install controller:
helm install aws-load-balancer-controller \
  eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=my-eks-cluster

Install via Helm:
helm repo add eks https://aws.github.io/eks-charts
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=my-eks \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller

Verify Controller:
kubectl get deployment -n kube-system aws-load-balancer-controller
kubectl logs -n kube-system deployment/aws-load-balancer-controller      

2. Deploy Application

apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 3

Service:
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: ClusterIP  


3. Create Ingress
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
  annotations:
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
spec:
  ingressClassName: alb
  rules:
  - host: app.company.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: nginx-service
            port:
              number: 80

Apply: kubectl apply -f ingress.yaml
kubectl get ingress
kubectl describe ingress app-ingress

AWS automatically provisions:
ALB, Target Groups, Listeners, Security Groups

4. Enable HTTPS
Create ACM certificate:

aws acm request-certificate \
  --domain-name app.company.com \
  --validation-method DNS

5. Configure Route53
Create Alias Record:
app.company.com → ALB DNS Name  

6. Add WAF
Attach AWS WAF to ALB.
Protect against:
SQL Injection, XSS, Bot traffic, DDoS (with AWS Shield)

Q. How do you secure the Ingress?
I would:
Use ACM-managed certificates
Enable HTTPS only
Attach WAF
Restrict Security Groups
Use Network Policies
Enable IRSA
Enable ALB access logging

# What have you personally configured?”
In production on EKS, I expose services through an internet-facing Application Load Balancer managed by the AWS Load Balancer Controller, not by exposing NodePorts directly. 
The flow is Route53 → ALB → Kubernetes Ingress → ClusterIP Service → Pods. 
I keep worker nodes in private subnets, terminate TLS at the ALB using ACM certificates, enable HTTP-to-HTTPS redirect, configure ALB health checks against readiness endpoints, and attach AWS WAF for OWASP and rate-limiting protection. 
The controller runs with IRSA (IAM Roles for Service Accounts) so it has least-privilege AWS permissions. 
This gives secure public exposure, centralized TLS and WAF, host/path-based routing, and a scalable multi-AZ architecture.

1. How would you route multiple services under one ALB using path-based or host-based rules?

We deploy the AWS Load Balancer Controller using IRSA so it can create AWS ALBs securely. Then we create a Kubernetes Ingress resource with ALB annotations. The ALB listens on HTTPS using an ACM certificate. Based on either the hostname or the URL path, the ALB forwards traffic to different Kubernetes Services.

For example:   

# 2. How do you restrict this ALB so only certain IP ranges or a VPN can reach it?
"The approach depends on the application's exposure requirements.

For internal enterprise applications, I create an Internal ALB in private subnets so it isn't internet-facing. Users connect through AWS Client VPN or a Site-to-Site VPN before accessing the application.

If a public ALB is required but access should be limited, I restrict inbound access in the ALB Security Group to specific corporate public IP ranges. For additional protection, I attach AWS WAF to enforce IP allow lists, rate limiting, and managed security rules. This provides multiple layers of defense."

