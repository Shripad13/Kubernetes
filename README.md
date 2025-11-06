# Kubernetes

> KUBERNETES is top-notch Container Orchestration Tool.
K8s is Opensource with CNCF

In K8s, it will be shared storage across instances & containers in that & will have common network.

Group of resources delivers needed output & acts as single resource/entity.
High Availability is the main Motto.


> We should have a k8s cluster provisioned for learning k8s


# Other Container Orchestration Solutions -
1. K8s - Community based support/ opensource edition, will not get support from any company.
2. OpenShift - On Premise based k8  (support will be offered by RedHat)
3. Rancher
4. Tanzua (Product from VMWare)
5. Docker Swarm - not even in race of these.

Graduated means Product is certified
Incubating means Product is still in developing phase.
Sandbox meas Product which are used for demo/ Experimental purpose.

## Why K8s?
1. Backed by CNCF
2. Lot of Community support
3. It is an Opensource & freeware (No need to pay anyone)
4. Better than Docker Swarm, solves certain problems with Network & storage.
5. Cloud Native



## Managing k8s cluster by using EC2/ On-Prem Instances.
1. Create a Instance (t3.small or meduim with 30 GB)
2. Install RUn time (Podman docker)
3. Install k8s ()
4. Enroll the nodes 
5. Install kubectl (k8 client ot connect to the cluster)


## How Manual Installation of Kubernetes works? (How to provision a K8s CLuster)
1. On linux , we need to install docker or container run time (containerD is preferred) / Podman docker.
2. Install kuberetes solution on all the nodes and designate one of the Node as a Master & rest of the nodes are the worker nodes.
3. Once you Install Kubernetes on the master node, It offers you a TOKEN , using that TOKEN other nodes will be connected and acts as a worker nodes.
4. Ensure Kubelet is installed on all the worker nodes (Kubelet is the local leader for each worker nodes).
5. Your workloads will be running on the worker nodes.

## Using Managed Servcies from Cloud we can provision a K8s CLuster
AWS - EKS (Preferred)
GCP - GKE (Google K8s Engine)
AZure - AKS (Azure k8s service)
All 3 are not free tier

## Use a Learning Environment : Minikube
1. Create an EC2 Instance (t3.small or medium with 30 GB & expand the /var & /root-vol directories)
2. Install Minikube on it.

Most of the info can be availed from "kubernetes.io"

> Latest Kubernetes Version - 1.34

Always say in interview 2 versions behind, we keep our k8 2 verison behind as per org policy

Kubectl - k8's client used to connect to k8 cluster which is installed on the computer/server where we are connecting.

Kubelet - this is a local leader of worker node which is going to report node & worker status to the Master node.

## Kube API server
Kube API server port is 8336
The Kube API Server is the central management component of Kubernetes. It acts as the front-end of the Kubernetes control plane and is the single entry point for all administrative tasks.

##How it works in the Kubernetes architecture:
You run -  kubectl apply -f pod.yaml

kubectl sends the request to the API server.
API server:
1.Authenticates and authorizes the request.
2.Validates the pod spec.
3.Writes the new pod definition to etcd.
4.Notifies the kube-scheduler to place the pod.
5.Notifies the kubelet on the chosen node to create the pod.


#API Server: Central management component; only component that communicates with etcd.
#etcd: Stores all cluster data and configurations.
#Controller Manager: Ensures the desired state of the cluster is maintained.
#Scheduler: Assigns Pods to nodes based on resource availability.
#Worker Nodes: Execute the workloads (Pods) and provide necessary resources.

#How can we connect to Kubernetes cluster
1. kubecl (cli way of accessing the cluster, This is the most preferred way of use)
2. non-cli  (K9s)
3. K9's GUI (Octant)


# Kubernetes Architecture ########

Master Component also called as control plane 
One Kubernetes cluster consist of one master Node with multiple Worker/Data plane nodes along with Shared Storage.

k8's will have one master Node with multiple Worker/Data plane nodes along with Shared Storage.
In k8s, we have lot of resources & around all Pod is the smallest computing resource !!!

NodePool is a group of nodes of similar type.
One Cluster will have no. of NodePools.

## What is a Pod in K8s?

SYntax - kubectl verb resources
ex- kubectl get pods
    kubectl describe resources  

In k8s you dont run container, you run POD.
Pod has a ability to run more than one container.
POD contains the container.

In Projects, they host 2 Master Nodes, it will help in case of one fails.

A Pod is group of one or more containers with shared Storage & Network resources.  & a specification for how to run the containers.
K8's has Shared Network & Shared Storage solved between the pods which resolved critical problems.

K8's runs the applications in the form of pods, pod is nothing but wrapper to the containers, 
you can run n number of containers within the pod , it offers a single network & storage & going to solve problems of share n/w & storage.

K8's is all about API's
Each & every resource would be under a spcific API.
K8's offers lots of varities of resources.

kubectl api-version

## What is the purpose if Pod?
POD is used to run a container, its just a wrapper to containers.
A pod  can have more than one container.
BUt all the containers in the pod will have same Network & same Storage.


# Important use case on kubernetes cluster !!!
On k8. resources can be utilized very efficiently

1. If you have a k8 cluster, this can be logically provisioned in to multiple spaces & can be delegated into multiple teams.
2. you can host, QA, DEV, SIT enviropnments in a single cluster without having interference to each other.

This can be achieved by using a namspaces.

Namespace is a virtual boundary.

Bydefault on k8 cluster, resources in one namespace can communicate with other pods in other namespaces, however we can control the behaviour if we wish to restrict, using a policy called as Network Policy.

> On k8's cluster , we have these namespaces to host  different resources.

kubectl get namespace

kube-system [control plane components are hosted on this namespace]
kube-public [this is mostly empty by default]
default [k8's resources will be hosted on the default namepspace]

# ConfigMap
Whenever you have a set of properties or variables that needs to be supplied across the components of k8, then rather supplying manually, we tend to create a resource called as "ConfigMap" and we inject this ConfigMap in to the pods

