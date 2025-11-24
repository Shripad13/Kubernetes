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

# 